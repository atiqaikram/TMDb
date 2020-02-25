//
//  MoviesService.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

struct MoviesService{
    
    var networkHandler : NetworkHandler //TODO: there shouldn't be a space between : and variable name
    init(handler: NetworkHandler){
        self.networkHandler = handler
    }
    
}

extension MoviesService : DataModelDecoder { //TODO: there shouldn't be a space between : and struct name
    
    //TODO: Add xcode help documentation for the methos it should explain what the method does and what are the input variables and explain any output
    func fetchMovies( completion: @escaping (_ movies: MovieResults?)-> ()){
        networkHandler.fetchMoviesData(completion: {(data) in
        guard let data = data else {
            completion(nil)
            return
        }
        do {
            let movieResultModel : MovieResults? = try self.decodeModel(data: data)
            //TODO: There's no need for the gaurd let below if "movieResultModel" is nil it will automatically be passed as nil in the completion guard block is redundant.
            guard let movieResult = movieResultModel else {
                completion(nil)
                return
            }
            completion(movieResult)
        } catch {
            //TODO: if i just pass nil in the completion how will I show user that some error occured during the parsing or fetching or if the data is just not available. there should be some error variable in the completion block too which propogates any errors that may have been thrown by server.
            completion(nil)
        }
        })
    }
    //TODO: Add xcode help documentation for the methos it should explain what the method does and what are the input variables and explain any output
    func fetchGenres( completion: @escaping (_ movies: GenreResults?)-> ()){
        networkHandler.fetchGenreData(completion: {(data) in
        guard let data = data else {
            completion(nil)
            print("serivce out") //TODO: Dont leave print statements in the comitted code
            return
        }
        do {
            let genreResultModel : GenreResults? = try self.decodeModel(data: data)
            //TODO: There's no need for the gaurd let below if "genreResultModel" is nil it will automatically be passed as nil in the completion guard block is redundant.
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
