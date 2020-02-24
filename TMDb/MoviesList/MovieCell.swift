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
    
    let filledStar = UIImage(named: "filledStar")
    let emptyStar = UIImage(named: "emptyStar")
    var imageCheck = false
    
    @IBAction func favoriteTapped(_ sender: Any) {
        
        if imageCheck == false {
            favButton.setImage(filledStar, for: .normal)
            imageCheck = true
        }
        else {
            favButton.setImage(emptyStar, for: .normal)
            imageCheck = false
        }
        
        movieCellVM?.markAsFavorite()
    }
    
    override func prepareForReuse() {

    }
    
    private func setMovieImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
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
        rating.text = String(format:"%.1f", movieCellVM!.rating!)
    }
}
