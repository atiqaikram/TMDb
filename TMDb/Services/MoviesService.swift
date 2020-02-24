//
//  MoviesService.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

struct MoviesService{
    var networkHandler : NetworkHandler
    init(handler: NetworkHandler){
        self.networkHandler = handler
    }
    
}

extension MoviesService : DataModelDecoder {
    
    func fetchMovies( completion: @escaping (_ movies: MovieResults?)-> ()){
        networkHandler.fetchMoviesData(completion: {(data) in
        guard let data = data else {
            completion(nil)
            return
        }
        do {
            let movieResultModel : MovieResults? = try self.decodeModel(data: data)
            guard let movieResult = movieResultModel else {
                completion(nil)
                return
            }
            completion(movieResult)
        } catch {
            completion(nil)
        }
        })
    }
    
    func fetchGenres( completion: @escaping (_ movies: GenreResults?)-> ()){
        networkHandler.fetchGenreData(completion: {(data) in
        guard let data = data else {
            completion(nil)
            print("serivce out")
            return
        }
        do {
            let genreResultModel : GenreResults? = try self.decodeModel(data: data)
            guard let genreResult = genreResultModel else {
                completion(nil)
                return
            }
            completion(genreResult)
        } catch {
            completion(nil)
        }
        })
    }
    
    
}
