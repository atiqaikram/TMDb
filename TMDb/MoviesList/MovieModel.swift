//
//  Movie.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import UIKit



struct MovieModel : Codable {
    
    var backdrop_path: String?
    var title: String?
    var release_date: String?
    var vote_average: Double?
    var isFavorite: Bool?
    var overview: String?
    var genre_ids: [Int]?
    
    init(title: String, rating:Double, releaseDate:String, overview:String, imagepath:String){
           self.title = title
           self.vote_average = rating
           self.release_date = releaseDate
           self.overview = overview
           self.backdrop_path = URLS.image + imagepath
           isFavorite = false
           
       }
}
