//
//  Constants.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 17/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

enum URLS {
    
    static let image = "https://image.tmdb.org/t/p/w500"
    static let trending = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=0dc10f29ec705eedb41fdb912bbb063e")
    static let genres = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=0dc10f29ec705eedb41fdb912bbb063e&language=en-US")
}

enum Identifiers {
    
    static let MovieCell = "MovieCell"
}

