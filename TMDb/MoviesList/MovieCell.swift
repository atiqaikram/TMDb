//
//  MovieCell.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var moviePoster:     UIImageView!
    @IBOutlet weak var movieTitle:      UILabel!
    @IBOutlet weak var releaseDate:     UILabel!
    @IBOutlet weak var rating:          UILabel!
    @IBOutlet weak var favButton:       UIButton!
    
    var cellViewModel:                  MovieCellViewModel?
    var movieViewModel:                 MoviesViewModel?
    @IBAction func favoriteTapped(_ sender: Any) {
        let filledStar = #imageLiteral(resourceName: "filledStar")
        let emptyStar = #imageLiteral(resourceName: "emptyStar") 
        let currentState = cellViewModel?.cellFavoriteState()
        if currentState == true {
            cellViewModel?.unmarkAsFavorite()
            favButton.setImage(emptyStar, for: .normal)
        } else {
            cellViewModel?.markAsFavorite()
            favButton.setImage(filledStar, for: .normal)
        }
    }
    private func placeMovieImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.moviePoster.image = image
            }
        }
    }
    func setupCellWithModel(_ movie: MovieModel){
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        cellViewModel = MovieCellViewModel(movie: movie)
        guard let moviePosterPath = cellViewModel?.cellPosterPath() else { return }
        placeMovieImage(from: moviePosterPath)
        movieTitle.text = cellViewModel?.cellTitle()
        releaseDate.text = cellViewModel?.cellReleaseDate()
        guard let movieRating = cellViewModel?.cellRating() else { return }
        rating.text = String(format:"%.1f", movieRating)
        if let movieState = movie.isFavorite {
            favButton.setImage(movieState ? filledStar : emptyStar, for: .normal)
        }
    }
}
