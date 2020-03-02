//
//  MovieCellVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

struct MovieCellViewModel {
    
    private var posterPath:     String?
    private var title:          String?
    private var releaseDate:    String?
    private var rating:         Double?
    private var isFavorite:     Bool?
    private var overview:       String?
    private var genreID:        [Int]?
    private var ref :           DatabaseReference?
    
    private var moviesVM =  MoviesViewModel()
    
    mutating func markAsFavorite(){
        ref = Database.database().reference()
        guard let user = userID.shared.id else { return }
        print("user from cell", user)
        self.isFavorite = true
        guard let movieName = self.title else { return }
        ref?.child(user).child("favorite_movies").child(movieName).updateChildValues(["isFavorite": true])
    }
    mutating func unmarkAsFavorite(){
        ref = Database.database().reference()
        guard let user = userID.shared.id else { return }
        guard let movieName = self.title else { return }
        self.isFavorite = false
        ref?.child(user).child("favorite_movies").child(movieName).removeValue()
    }
    
    init(movie: MovieModel){
        
        posterPath = URLS.image + movie.backdropPath!
        title = movie.title
        releaseDate = movie.releaseDate
        rating = movie.voteAverage
        isFavorite = movie.isFavorite
        overview = movie.overview
        genreID = movie.genreIds
    }
    
    func cellPosterPath()-> String?{
        return posterPath
    }
    func cellTitle()-> String?{
        return title
    }
    func cellReleaseDate() -> String?{
        return releaseDate
    }
    func cellRating()-> Double?{
        return rating
    }
    func cellFavoriteState()-> Bool?{
        return isFavorite
    }
    func cellOverview()-> String?{
        return overview
    }
    func cellGenreID()-> [Int]?{
        return genreID
    }
    
}
