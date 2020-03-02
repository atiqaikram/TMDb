//
//  MoviesViewControllerVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import FirebaseDatabase
enum state{
    case defaultView
    case genre
    case date
}
class MoviesViewModel {
    private var movies:          Bindable<[MovieModel]> = Bindable([MovieModel] ())
    private var genres:          [GenreModel] = [GenreModel] ()
    private var originalMovies:  [MovieModel] = [MovieModel]()
    private var moviesService =  MoviesService(handler: NetworkHandler())
    private var viewState:       state = .defaultView
    private var ref:             DatabaseReference?

    func downloadMovies(){
        moviesService.fetchMovies (completion: { [weak self] (MovieResults) in
            guard let movies = MovieResults else {
                return
            }
            self?.movies.value = movies.results
            self?.originalMovies = movies.results
        })
   }
    func downloadGenres(){
        moviesService.fetchGenres(completion: { [weak self] (GenreResults) in
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
    func genreName(index: Int) -> String {
        guard let genreName =  genres[index].name else {return ""}
        return genreName
    }
    func genreId(index: Int) -> Int{
        guard let genreID = genres[index].id  else {return 0}
        return genreID
    }
    func movieCount() -> Int {
        return movies.value.count
    }
    func movieToShow(index: Int) -> MovieModel {
        if movies.value[index].isFavorite == nil {
            movies.value[index].isFavorite = false
        }
        return movies.value[index]
    }
    func movieList() -> Bindable<[MovieModel]> {
        return movies
    }
    func releaseDateFilter(date: String){
       movies.value = movies.value.filter({ $0.releaseDate == date })
    }
    func genreFilter(genreID: Int){
        movies.value = movies.value.filter({ ($0.genreIds?.contains(genreID))!})
    }
    func currentState()-> state{
        return viewState
    }
    func setState(changedState: state){
        viewState = changedState
    }
    func observeAddedChild(){
        ref = Database.database().reference()
        guard let user = userID.shared.id else { return }
        _ = ((ref?.child(user).child("favorite_movies").observe(DataEventType.childAdded, with: { (snapshot) in
            let favoriteMovieTitle = (snapshot.key)
            self.setFavoriteValueOf(movie: favoriteMovieTitle, flag: true)
        }))!)
    }
    func observeRemovedChild(){
        ref = Database.database().reference()
        guard let user = userID.shared.id else { return }
        _ = ((ref?.child(user).child("favorite_movies").observe(DataEventType.childRemoved, with: { (snapshot) in
                   let favoriteMovieTitle = (snapshot.key)
            self.setFavoriteValueOf(movie: favoriteMovieTitle, flag: false)
               }))!)
    }
    func setFavoriteValueOf(movie: String, flag: Bool){
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
