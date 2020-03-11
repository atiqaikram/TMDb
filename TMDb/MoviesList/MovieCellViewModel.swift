//
//  MovieCellVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import UIKit

//TODO: there shouldn't be a space between struct name and : and there should be a space between : and FirebaseService
struct MovieCellViewModel :FirebaseService {
    private var posterPath:     String?
    private var title:          String?
    private var releaseDate:    String?
    private var rating:         Double?
    private var isFavorite:     Bool?
    private var overview:       String?
    private var genreID:        [Int]?
    private var moviesVM      = MoviesViewModel()

    mutating func markAsFavorite(){
        self.isFavorite = true
        //TODO: no need to use self.title use title only
        guard let movieName = self.title else { return }
        addMovieToFavorites(movieName)
}
    mutating func unmarkAsFavorite(){
        self.isFavorite = false
         //TODO: no need to use self.title use title only
        guard let movieName = self.title else { return }
        removeMovieFromFavorites(movieName)
    }
    init(movie: MovieModel){
        posterPath = URLS.image + movie.backdropPath! //TODO: dont force unwrap backdropPath use guard statment and set posterPath to nil if backdropPath doesn't exist
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
