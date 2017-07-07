//
//  ServiceRestable.swift
//  achados
//
//  Created by Diego Cavalcante on 07/07/17.
//  Copyright © 2017 Diego Cavalcante. All rights reserved.
//

import Foundation

struct RestableService<T> :  Restable {
    var path    : String
    var params  : JSON?
}
