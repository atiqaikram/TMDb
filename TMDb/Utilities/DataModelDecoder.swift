//
//  DataModelDecoder.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

protocol DataModelDecoder {}

extension DataModelDecoder  { //TODO: There's an extra space between the protocol name and curlly bracket. Please be careful not to leave such spaces in the code.
    
    //TODO: Add method help documentation
    func decodeModel<DataModel: Codable>(data: Data?) throws -> DataModel? {
        
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        do{
            let downloadedResults = try decoder.decode(DataModel.self, from: data)
            return downloadedResults
        }
        catch {
            print("something went wrong after downloaded") //TODO: don't leave print statements in the code.
            return nil
        }
    
    }
}

//TODO: Don't leave commented out code in the commit. Please delete the code below.
/*class a {
    let b = NetworkHandler()
    func c () {
        b.downloadMoviesJson { movies in
            
        }
    }
}*/
