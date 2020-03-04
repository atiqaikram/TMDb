//
//  DataModelDecoder.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 21/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation

protocol DataModelDecoder{}

extension DataModelDecoder{
    /// Data to specified Model decoder, Model must confirm the *Decodable*  protocol
       /// throws error if failed to decode model
       /// Returns specified  model or nil in case input *data* parameter is nil or decoding fails
       /// - Parameter data: *Data* object to be  decoded
    func decodeModel<DataModel: Codable>(data: Data?) throws -> DataModel?{
        guard let data = data else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do{
            let downloadedResults = try decoder.decode(DataModel.self, from: data)
            return downloadedResults
            
        }
        catch (let decodeError) {
            throw decodeError
        }
    }
}

