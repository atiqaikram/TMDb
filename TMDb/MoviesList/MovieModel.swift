//
//  Movie.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.

import Foundation
struct MovieModel: Codable{
    var backdropPath:   String?
    var title:          String?
    var releaseDate:    String?
    var voteAverage:    Double?
    var overview:       String?
    var genreIds:       [Int]?
    var isFavorite:     Bool?
}
