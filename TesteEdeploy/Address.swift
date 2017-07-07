//
//  Address.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation


class Address : NSObject {
    var city    : String?
    var state   : String?
    var addresses : [Address] = [Address]()
    
    override init() {}
    
    init(city : String, state : String) {
        self.city   = city
        self.state  = state
    }

     init?(data : Any) {
        guard
            let array = data as? JSONArray else {
            return
        }
        
        for json in array {
            let address = Address()
            address.city = json["Nome"] as? String
            address.state = json["Estado"] as? String
            addresses.append(address)
        }
    }
    
    func filter(by address : (String, String)) {
        addresses.filter(by: Address(city: address.0, state: address.1))
    }
}
