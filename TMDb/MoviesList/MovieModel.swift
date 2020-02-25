//
//  Movie.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import UIKit



struct MovieModel : Codable {//TODO: variable names should be in camelCase not snake_case. You can write give codeables a decoding trategy to map the snake_case to camelCase in your DataModelDecoder class.
    var backdrop_path: String?
    var title: String?
    var release_date: String?
    var vote_average: Double?
    var isFavorite: Bool?
    var overview: String?
    var genre_ids: [Int]?
    //TODO: why do you need these init methods? Deccodable protocol will initialise these variables for you so you can delete these init methods from decodable models
    init(title: String, rating:Double, releaseDate:String, overview:String, imagepath:String){
           self.title = title
           self.vote_average = rating
           self.release_date = releaseDate
           self.overview = overview
           self.backdrop_path = URLS.image + imagepath
           isFavorite = false //TODO: dont leave empty spaces between code and methods closing bracket
           
       }
}
