//
//  NetworkHandler.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
struct NetworkHandler{
    
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
