//
//  Restable.swift
//  achados
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation

public typealias JSON       = [String : Any]
public typealias JSONArray  = [[String : Any]]

protocol Restable {
    var path    : String { get set }
    var params  : JSON?  { get set }
}
public enum HttpMethod : String {
    case Get    = "GET"
    case Post   = "POST"
}

extension Restable {
    
    func get<T>(parse : @escaping (Any)-> T?, callback : @escaping (Any?)-> ()) {
        let resourceURL = URL(string: path)!
        let session = URLSession.shared
        session.dataTask(with: resourceURL) { data, _, error in
            let json = data.flatMap {
                try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            DispatchQueue.main.async {
                callback(error == nil ? json.flatMap(parse) : error)
            }
        }.resume()
    }
    
    
    func post<T>(parse : @escaping (Any)-> T?, callback : @escaping (Any?)-> ()) {
        guard
            let url = URL(string: path) else {
                return
            }
        
        var request = URLRequest(url: url)
        request.httpMethod  = HttpMethod.Get.rawValue
        request.httpBody    = try? JSONSerialization.data(withJSONObject: params ?? [:], options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, _, error) in
            let json = data.flatMap {
                try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            DispatchQueue.main.async {
                callback(error == nil ? json.flatMap(parse) : error)
            }
        }.resume()
    }
}