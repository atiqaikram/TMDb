//
//  Firebase.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 03/03/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import Foundation
import Firebase
class FirebaseService{
    private var ref:        DatabaseReference?
    private var moviesVM:   MoviesViewModel?
    init(){
        ref = Database.database().reference()
    }
    init (vm: MoviesViewModel?){
        ref = Database.database().reference()
        moviesVM = vm
    }
    func observeAddedChild(){
        guard let user = userID.shared.id else { return }
        _ = ((ref?.child(user).child("favorite_movies").observe(DataEventType.childAdded, with: { (snapshot) in
            let favoriteMovieTitle = (snapshot.key)
            self.moviesVM?.setFavoriteValueOf(movie: favoriteMovieTitle, flag: true)
        }))!)
    }
    func observeRemovedChild(){
        guard let user = userID.shared.id else { return }
        _ = ((ref?.child(user).child("favorite_movies").observe(DataEventType.childRemoved, with: { (snapshot) in
            let favoriteMovieTitle = (snapshot.key)
            self.moviesVM?.setFavoriteValueOf(movie: favoriteMovieTitle, flag: false)
               }))!)
    }
    func addMovieToFavorites(movieName: String){
        guard let user = userID.shared.id else { return }
        ref?.child(user).child("favorite_movies").child(movieName).updateChildValues(["isFavorite": true])
    }
    func removeMovieFromFavorites(movieName: String){
        guard let user = userID.shared.id else { return }
        ref?.child(user).child("favorite_movies").child(movieName).removeValue()
    }
}
