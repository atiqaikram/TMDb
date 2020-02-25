//
//  GenreModel.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 18/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

struct GenreModel : Codable {//TODO: There shouldn't be a space between : and struct name and also remove the extra new line below between variable id and struct starting bracket
    
    var id: Int?
    var name: String?
}
