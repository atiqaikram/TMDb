//
//  Firebase.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 03/03/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import Firebase
protocol FirebaseService {
    
    func observeAddedChild(movieName: @escaping (String) -> ())
    func observeRemovedChild(movieName: @escaping (String) -> ())
    func addMovieToFavorites(_ movieName: String)
    func removeMovieFromFavorites(_ movieName: String)
}
extension FirebaseService{
    func addMovieToFavorites(_ movieName: String){
    guard let user = userID.shared.id else { return }
    Database.database().reference().child(user).child("favorite_movies").child(movieName).updateChildValues(["isFavorite": true])
    }
    func removeMovieFromFavorites(_ movieName: String){
        guard let user = userID.shared.id else { return }
        Database.database().reference().child(user).child("favorite_movies").child(movieName).removeValue()
    }
    func observeAddedChild(movieName: @escaping (String) -> ()) {
        guard let user = userID.shared.id else { return }
        ((Database.database().reference().child(user).child("favorite_movies").observe(DataEventType.childAdded, with: { (snapshot) in
            let favoriteMovieTitle = snapshot.key
            movieName(favoriteMovieTitle)
        })))
    }
    func observeRemovedChild(movieName: @escaping (String) -> ()) {
        guard let user = userID.shared.id else { return }
        ((Database.database().reference().child(user).child("favorite_movies").observe(DataEventType.childRemoved, with: { (snapshot) in
            let favoriteMovieTitle = snapshot.key
            movieName(favoriteMovieTitle)
        })))
    }
}
