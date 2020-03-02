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
    func fetchMovies( completion: @escaping (_ movies: MovieResults?)-> ()){
        guard let trendingURL = URLS.trending else { return }
        networkHandler.fetchData(path: trendingURL, completion: {(data, error) in
        guard let data = data else {
            completion(nil)
            return
        }
        do {
            let movieResultModel: MovieResults? = try self.decodeModel(data: data)
            let movieResult = movieResultModel
            completion(movieResult)
        } catch {
            completion(nil)
        }
        })
    }
    
    func fetchGenres( completion: @escaping (_ movies: GenreResults?)-> ()){
        guard let genresURL = URLS.genres else { return }
        networkHandler.fetchData(path: genresURL, completion: {(data, error) in
        guard let data = data else {
            completion(nil)
            return
        }
        do {
            let genreResultModel : GenreResults? = try self.decodeModel(data: data)
            let genreResult = genreResultModel
            completion(genreResult)
        } catch {
            completion(nil)
        }
        })
    }
}
