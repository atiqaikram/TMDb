//
//  userID.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 28/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
struct userID{
    static var shared = userID()
    var id: String?
    
    private init(){}
    mutating func setID(sentId: String){
        id = sentId
    }
}
