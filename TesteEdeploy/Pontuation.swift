//
//  Pontuation.swift
//  TesteEdeploy
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import UIKit

class Pontuation: NSObject {
    
    var pontuation : Double!
    
    override init() {
        super.init()
        pontuation = 0.0
    }
    
    init?(data : Any) {
        guard
            let pontuation = data as? Double else {
                return
            }
        
        self.pontuation = pontuation
    }
}
