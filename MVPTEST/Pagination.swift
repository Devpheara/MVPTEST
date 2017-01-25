//
//  Pagination.swift
//  MVPTEST
//
//  Created by Eang Pheara on 12/27/16.
//  Copyright © 2016 Eang Pheara. All rights reserved.
//

import Foundation

class Pagination{
    
    //can not init it is singalton
    private init(){}
    
    // share instance
    static let shared = Pagination()
    
    
    //Property
    var totalPage: Int = 0
    var currentPage: Int = 0
}
