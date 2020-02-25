//
//  NetworkHandler.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
struct NetworkHandler{
    
    //TODO: There's no need to have two separate methods here. Network handler must have just one method which should take an inout parameter with value like "URLS.trending" or "URLS.genres" and mjust return a completion handler with data or error. If you look at the methods below they are essentially the same just the API path is different which could be passed as input. Moreover your completion handler just returns data also propagate the errors in the completion blocks so that one could show such errors to user or give useful feedback so that they know what went wrong. Right now they will be in the dark if data is nil.
    func fetchMoviesData(completion: @escaping (_ data: Data?)-> ()){
        
        guard let downloadURL = URLS.trending else { return completion(nil) }
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error)  in
        completion(data)
        }.resume()
    }
    
    func fetchGenreData(completion: @escaping (_ data: Data?)-> ()){
        
        guard let downloadURL = URLS.genres else { return completion(nil) }
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error)  in
        completion(data)
        }.resume()
    }
}
