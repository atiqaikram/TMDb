//
//  GenreResults.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 24/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

struct GenreResults : Codable {//TODO: remove the space between : and struct name
    var genres: [GenreModel]
    //TODO: no need for init method
    init(movieGenres: [GenreModel]){
        self.genres =  movieGenres
    }
}
