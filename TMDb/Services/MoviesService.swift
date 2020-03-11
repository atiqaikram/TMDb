//
//  MoviesService.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

struct MoviesService{
    var networkHandler:     NetworkHandler
    
    init(handler: NetworkHandler){
        self.networkHandler = handler
    }
}

extension MoviesService: DataModelDecoder{
    /// Fetches the list of movies using the *The Movie Database API * (Trending)
    /// - Parameter completion: Completion closure with  *MovieResults*  objects or error string
    func fetchMovies( completion: @escaping (_ movies: MovieResults?, _ error: Error?)-> ()){
        guard let trendingURL = URLS.trending else { return }
        networkHandler.fetchData(path: trendingURL, completion: {(data, error) in
        guard let data = data else {
            completion(nil, error)
            return
        }
        do {
            let movieResultModel: MovieResults? = try self.decodeModel(data: data)
            completion(movieResultModel, nil)
        } catch {
            completion(nil, error)
        }
        })
    }
    /// Fetches the list of movies using the *The Movie Database API * (Genres)
    /// - Parameter completion: Completion closure with  *MovieResults*  objects or error string
    func fetchGenres( completion: @escaping (_ movies: GenreResults?, _ error: Error?)-> ()){
        guard let genresURL = URLS.genres else { return }
        networkHandler.fetchData(path: genresURL, completion: {(data, error) in
        guard let data = data else {
            completion(nil, error)
            return
        }
        do {
            let genreResultModel : GenreResults? = try self.decodeModel(data: data)
            //TODO: no need for the line of code below its just assigning the reference why not pass the original variable
            let genreResult = genreResultModel
            completion(genreResult, nil)
        } catch {
            completion(nil, error)
        }
        })
    }
}
