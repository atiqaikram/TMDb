//
//  MovieCellVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import UIKit

struct MovieCellViewModel {
    
    private var posterPath:     String?
    private var title:          String?
    private var releaseDate:    String?
    private var rating:         Double?
    private var isFavorite:     Bool?
    private var overview:       String?
    private var genreID:        [Int]?
    
    private var moviesVM             = MoviesViewModel()
    lazy private var firebaseService = FirebaseService()
    
    mutating func markAsFavorite(){
        self.isFavorite = true
        guard let movieName = self.title else { return }
        firebaseService.addMovieToFavorites(movieName: movieName)
    }
    mutating func unmarkAsFavorite(){
        self.isFavorite = false
        guard let movieName = self.title else { return }
        firebaseService.removeMovieFromFavorites(movieName: movieName)
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
