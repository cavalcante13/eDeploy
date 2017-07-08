//
//  ArrayExtension.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation


extension Array where Element : Address {
    
    mutating func filter(by element : Element) {
        let predicate = NSPredicate(format: "(city contains[cd] %@) OR (state contains[cd] %@)", element.city ?? "", element.state ?? "")
        self = (self as NSArray).filtered(using: predicate) as! [Element]
    }
}
