//
//  NetworkHandler.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
struct NetworkHandler{
    /// Sends a  request for the requested API endpoint and returns a completion closure with Data object or error string
          /// - Parameter completion: returns data or error string
    func fetchData(path: URL, completion: @escaping (_ data: Data?,_ error: Error?)-> ()){
        URLSession.shared.dataTask(with: path as URL) { (data, urlResponse, error)  in
        completion(data, error)
        }.resume()
    }
}
