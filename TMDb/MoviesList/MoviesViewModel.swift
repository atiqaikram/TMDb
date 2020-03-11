//
//  MoviesViewControllerVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
enum state{//TODO: Use a meaningful name for this state for example viewType or viewtate
    case defaultView
    case genre
    case date
}
class MoviesViewModel : FirebaseService{
    private var movies:          Bindable<[MovieModel]> = Bindable([MovieModel]())
    private var genres:          [GenreModel] = [GenreModel] ()
    private var originalMovies:  [MovieModel] = [MovieModel]()
    private var moviesService                 = MoviesService(handler: NetworkHandler())
    private var viewState:             state  = .defaultView {
        didSet{
            if currentState() == .defaultView {
                resetMoviesList()
            }
        }
    }
    
    func downloadMovies(){
        moviesService.fetchMovies (completion: { [weak self] (MovieResults, error) in
            guard let movies = MovieResults else {
                return
            }
            self?.movies.value = movies.results
            self?.originalMovies = movies.results
        })
   }
    //TODO: This file is not properly indented.
    func downloadGenres(){
        moviesService.fetchGenres(completion: { [weak self] (GenreResults, error) in
            guard let genreResults = GenreResults else {
                return
            }
            self?.genres = genreResults.genres
        })
    }
    func resetMoviesList(){
        movies.value = originalMovies
    }
    func genreCount() -> Int {
        return genres.count
    }
    func genreName(for index: Int) -> String {
        guard let genreName =  genres[index].name else {return ""}
        return genreName
    }
    func genreId(for index: Int) -> Int{
        guard let genreID = genres[index].id  else {return 0}
        return genreID
    }
    func movieCount() -> Int {
        return movies.value.count
    }
    func movieToShow(at index: Int) -> MovieModel {
        if movies.value[index].isFavorite == nil {
            movies.value[index].isFavorite = false
        }
        return movies.value[index]
    }
    func movieList() -> Bindable<[MovieModel]> {
        return movies
    }
    func releaseDateFilter(for date: String){
       movies.value = movies.value.filter({ $0.releaseDate == date })
    }
    func genreFilter(for genreID: Int){
        //TODO: remove force unwrapping below use gaurd statement on genreIds and
        movies.value = movies.value.filter({ ($0.genreIds?.contains(genreID))!})
    }
    func currentState()-> state{
        return viewState
    }
    func updateState(_ changedState: state){
        viewState = changedState
    }
    func childAddedListener(){
        //TODO: capture weak reference instead of directly calling self
        observeAddedChild { (movieName) in
            self.updateFavoriteValue(for: movieName, flag: true)
        }
    }
    func childRemovedListener(){
        //TODO: capture weak reference instead of directly calling self
        observeRemovedChild { (movieName) in
            self.updateFavoriteValue(for: movieName, flag: false)
        }
    }
    private func updateFavoriteValue(for movie: String, flag: Bool){
        if let movieIndex = movies.value.firstIndex(where: { $0.title == movie }){
            movies.value[movieIndex].isFavorite = flag
            if viewState == .defaultView{
                originalMovies[movieIndex].isFavorite = flag
            } else {
                if let originalIndex = originalMovies.firstIndex(where: { $0.title == movie }){
                    originalMovies[originalIndex].isFavorite = flag
                }
            }
        }
     }
}
