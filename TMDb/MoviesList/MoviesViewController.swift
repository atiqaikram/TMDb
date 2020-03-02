//
//  ViewController.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesTableView:     UITableView!
    @IBOutlet weak var genreButton:         UIBarButtonItem!
    @IBOutlet weak var filterButton:        UIBarButtonItem!
    @IBOutlet weak var datePicker:          UIDatePicker!
    @IBOutlet weak var genrePicker:         UIPickerView!
    @IBOutlet weak var bottomContainerView: UIView!
    
    var moviesViewModel = MoviesViewModel()
    var cellView   = MovieCell()
    
    override func viewDidLoad() {
        print("email from moviesvc: ", userID.shared.id)
        super.viewDidLoad()
        moviesTableView.rowHeight = UITableView.automaticDimension
        bindVM()
    }
    
    private func bindVM() {
        moviesViewModel.downloadMovies()
        moviesViewModel.downloadGenres()
        moviesViewModel.observeAddedChild()
        moviesViewModel.observeRemovedChild()
        moviesViewModel.movieList().bind({ [weak self] _ in
        DispatchQueue.main.async {
            self?.moviesTableView.reloadData()
        }
        })
    }
}

//MARK:- TableView DataSource and Delegate
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesViewModel.movieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.MovieCell, for: indexPath) as? MovieCell else {
           return UITableViewCell()
        }
        cell.setUpCellWithModel(movie: (moviesViewModel.movieToShow(index: indexPath.row)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: Identifiers.MovieDetail) as? MoviesDetailsViewController {
            let movie = moviesViewModel.movieToShow(index: indexPath.row)
            movieDetailViewController.viewModel.detailModel = movie
            self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK:- PickerView DataSource and Delegate
extension MoviesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moviesViewModel.genreCount() 
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moviesViewModel.genreName(index: row)
    }
}


// Release date and Genre filter functions
extension MoviesViewController {
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        if filterButton.title == "Remove Filter" {
            genreButton.isEnabled = true
            moviesViewModel.setState(changedState: state.defaultView)
            moviesViewModel.resetMoviesList()
            filterButton.title = "Filter"
        }
        else {
            genreButton.isEnabled = false
            moviesViewModel.setState(changedState: .date)
            bottomContainerView.isHidden = false
            datePicker.isHidden = false
            genrePicker.isHidden = true
            datePicker.datePickerMode = UIDatePicker.Mode.date
       }
    }
    @IBAction func genreButtonPressed(_ sender: Any) {
        if genreButton.title == "Remove Filter" {
            filterButton.isEnabled = true
            moviesViewModel.setState(changedState: state.defaultView)
            moviesViewModel.resetMoviesList()
            genreButton.title = "Genre"
        }
        else{
            filterButton.isEnabled = false
            genrePicker.reloadAllComponents()
            moviesViewModel.setState(changedState: .genre)
            bottomContainerView.isHidden = false
            genrePicker.isHidden = false
            datePicker.isHidden = true
        }
    }
    @IBAction func doneButton(_ sender: Any) {
        bottomContainerView.isHidden = true
        if moviesViewModel.currentState() == .date{
            releaseDateSelected(sender: datePicker)
        }
        else if moviesViewModel.currentState() == .genre{
            let pickedGenreId = (moviesViewModel.genreId(index: genrePicker.selectedRow(inComponent: 0)))
            genreSelected(genreID :pickedGenreId)
        }
    }
    func releaseDateSelected(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: datePicker.date)
        moviesViewModel.releaseDateFilter(date: strDate)
        filterButton.title = "Remove Filter"
       }
    func genreSelected(genreID: Int){
           moviesViewModel.genreFilter(genreID: genreID)
           genreButton.title = "Remove Filter"
       }
}
