//
//  DoubleExtension.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation



extension Double {
    
    
    func decimal()-> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
