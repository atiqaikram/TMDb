//
//  MoviesViewControllerVM.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 14/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

class MoviesViewModel  {
    private var movies : Bindable<[MovieModel]> = Bindable([MovieModel] ()) //TODO: remove space between : and variable names
    private var genres : [GenreModel] = [GenreModel] () 
    private var originalMovies : [MovieModel] = [MovieModel]()
    var moviesService = MoviesService(handler: NetworkHandler())//TODO: give an extra newline between variable names and methods
    func downloadMovies(){
        moviesService.fetchMovies { (MovieResults) in //TODO: use weak self capture in closures instead of capturing a strong reference you could write [weak self] before "(GenreResults)" to do that.
            //TODO: use guard let instead of if let in this case, code would be more readable.
            if MovieResults != nil {
                self.movies.value = MovieResults!.results //TODO: use if let or guard let dont use ! to force unwrap things even if you have made sure its not nil it still is not a good read
                self.originalMovies = self.movies.value
            }
            else {
                return
            }
        }
    }
    
    func downloadGenres(){
        moviesService.fetchGenres(completion: { (GenreResults) in //TODO: use weak self capture in closures instead of capturing a strong reference you could write [weak self] before "(GenreResults)" to do that.
            //TODO: use guard let instead of if let in this case, code would be more readable.
            if GenreResults != nil {
                self.genres = GenreResults!.genres//TODO: use if let or guard let dont use ! to force unwrap things even if you have made sure its not nil it still is not a good read
            }
            else {
                return
            }
        })
    }
   
    func resetMoviesList(){
        self.movies.value = self.originalMovies //TODO: no need to explicitly use self reference outside of blocks just write movies.value = originalMovies
    }
    func getGenreCount() -> Int { //TODO: dont use get in method names just go with GenreCount
        return self.genres.count  //TODO: no need to explicitly use self reference outside of blocks
    }
    func getGenreName(index: Int) -> String { //TODO: dont use get in method names just go with GenreName
        guard let genreName =  self.genres[index].name else {return ""} //TODO: no need to explicitly use self reference outside of blocks
        return genreName
    }
    func getGenreId(index: Int) -> Int{ //TODO: dont use get in method names just go with GenreId
        guard let genreID = self.genres[index].id  else {return 0}  //TODO: no need to explicitly use self reference outside of blocks
        return genreID
    }
    func getMovieCount() -> Int {  //TODO: dont use get in method names just go with MovieCount
        return self.movies.value.count
    }
    func getMovie(index: Int) -> MovieModel { //TODO: dont use get in method names it copuld be something like movieToShow or MovieForDetail etc
        return self.movies.value[index]  //TODO: no need to explicitly use self reference outside of blocks
    }
    func getMovieList() -> Bindable<[MovieModel]> {  //TODO: dont use get in method names
        return self.movies  //TODO: no need to explicitly use self reference outside of blocks
    }
    func releaseDateFilter(date: String){
        self.movies.value = self.movies.value.filter({ $0.release_date == date })  //TODO: no need to explicitly use self reference outside of blocks
    }
    func genreFilter(genreID: Int){
        //TODO: in the filter statement just use $0.genre_ids?.contains(genreID) there's no need to explicitly make sure its true since if its already true it will return true :)
        self.movies.value = self.movies.value.filter({ $0.genre_ids?.contains(genreID) == true })  //TODO: no need to explicitly use self reference outside of blocks
    }
}


