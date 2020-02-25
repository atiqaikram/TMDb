//
//  MovieCell.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    var movieCellVM: MovieCellViewModel?
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    //TODO: no need to keep these images as class level variables
    let filledStar = UIImage(named: "filledStar")
    let emptyStar = UIImage(named: "emptyStar")
    var imageCheck = false //TODO: rename this variable to some menaingful name imageCheck looks odd
    
    //TODO: why do you have this method setting images. I would say setting these imaghes in storybaord for different button states is a better option. lets discuss in person if there's confusion
    @IBAction func favoriteTapped(_ sender: Any) {
        
//        favButton.setImage(imageCheck ? emptyStar : filledStar, for: .normal)
//        imageCheck = !imageCheck
        
        //TODO:- what's the difference b/w code above and code below, do you think code above coulkd replace the one that you wrote?
        
        if imageCheck == false {
            favButton.setImage(filledStar, for: .normal)
            imageCheck = true
        }
        else {//TODO: else should be on the same line as closing bracket of if
            favButton.setImage(emptyStar, for: .normal)
            imageCheck = false
        }
        
        movieCellVM?.markAsFavorite()
    }
    //TODO: remove the empty method below
    override func prepareForReuse() {

    }
    
    private func setMovieImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async { //TODO: capture weak self reference by using [weak self]
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.moviePoster.image = image
            }
        }
    }
    
    func setUpCellWithModel(movie: MovieModel){
        movieCellVM = MovieCellViewModel(movie: movie)
        setMovieImage(from: movieCellVM!.posterPath!)
        movieTitle.text = movieCellVM?.title
        releaseDate.text = movieCellVM?.releaseDate
        rating.text = String(format:"%.1f", movieCellVM!.rating!) //TODO: remove force unwrapping use guard let or if let statements
    }
}
