//
//  MovieResults.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 24/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
struct MovieResults : Codable {
    var results: [MovieModel]
    //TODO: no need for init method
    init(movies: [MovieModel]){
        self.results =  movies
    }
}
