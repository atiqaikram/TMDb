//
//  MoviesViewControllerVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

class MoviesViewModel  {
    private var movies : Bindable<[MovieModel]> = Bindable([MovieModel] ())
    private var genres : [GenreModel] = [GenreModel] () 
    private var originalMovies : [MovieModel] = [MovieModel]()
    var moviesService = MoviesService(handler: NetworkHandler())
    func downloadMovies(){
        moviesService.fetchMovies { (MovieResults) in
            if MovieResults != nil {
                self.movies.value = MovieResults!.results
                self.originalMovies = self.movies.value
            }
            else {
                return
            }
        }
    }
    
    func downloadGenres(){
        moviesService.fetchGenres(completion: { (GenreResults) in
            if GenreResults != nil {
                self.genres = GenreResults!.genres
            }
            else {
                return
            }
        })
    }
   
    func resetMoviesList(){
        self.movies.value = self.originalMovies
    }
    func getGenreCount() -> Int {
        return self.genres.count
    }
    func getGenreName(index: Int) -> String {
        guard let genreName =  self.genres[index].name else {return ""}
        return genreName
    }
    func getGenreId(index: Int) -> Int{
        guard let genreID = self.genres[index].id  else {return 0}
        return genreID
    }
    func getMovieCount() -> Int {
        return self.movies.value.count
    }
    func getMovie(index: Int) -> MovieModel {
        return self.movies.value[index]
    }
    func getMovieList() -> Bindable<[MovieModel]> {
        return self.movies
    }
    func releaseDateFilter(date: String){
        self.movies.value = self.movies.value.filter({ $0.release_date == date })
    }
    func genreFilter(genreID: Int){
        self.movies.value = self.movies.value.filter({ $0.genre_ids?.contains(genreID) == true })
    }
}


