//
//  MovieCellVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import UIKit


struct MovieCellViewModel {//TODO: remove the new line between struct starting bracket and variable name
    
    var posterPath: String?
    var title: String?
    var releaseDate: String?
    var rating: Double?
    var isFavorite: Bool?
    var overview: String?
    var genre_ids: [Int]?
    
    mutating func markAsFavorite(){
        isFavorite = true
    }
    
    init(movie: MovieModel){
        
        posterPath = URLS.image + movie.backdrop_path!
        title = movie.title
        releaseDate = movie.release_date
        rating = movie.vote_average
        isFavorite = movie.isFavorite
        overview = movie.overview
        genre_ids = movie.genre_ids
    }
    
    
}
