//
//  MoviesDetailsViewController.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import UIKit

class MoviesDetailsViewController: UIViewController {

    @IBOutlet weak var moviePoster:       UIImageView!
    @IBOutlet weak var movieTitle:        UILabel!
    @IBOutlet weak var movieRating:       UILabel!
    @IBOutlet weak var movieOverview:     UITextView!
    
    var viewModel = MovieDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = viewModel.detailModel?.title
        movieOverview.text = viewModel.detailModel?.overview
        guard let path = viewModel.detailModel?.backdropPath, let voteAng = viewModel.detailModel?.voteAverage else {return}
        setMovieDetailImage(from: URLS.image + path)
        movieRating.text = String(format:"%.1f", voteAng)
    }
    func setMovieDetailImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self?.moviePoster.image = image
            }
        }
    }
}

