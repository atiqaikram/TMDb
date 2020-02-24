//
//  DataModelDecoder.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

protocol DataModelDecoder {}

extension DataModelDecoder  {
    func decodeModel<DataModel: Codable>(data: Data?) throws -> DataModel? {
        
        guard let data = data else {
            return nil
        }
        let decoder = JSONDecoder()
        do{
            let downloadedResults = try decoder.decode(DataModel.self, from: data)
            return downloadedResults
            
        }
        catch {
            print("something went wrong after downloaded")
            return nil
        }
    
    }
}


/*class a {
    let b = NetworkHandler()
    func c () {
        b.downloadMoviesJson { movies in
            
        }
    }
}*/
