//
//  ViewController.swift
//  TMDb
//
//  Created by Atiqa Ikram  on 13/02/2020.
//  Copyright © 2020 Atiqa Ikram . All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
   
   
    let datePicker : UIDatePicker = UIDatePicker()
    let genrePicker: UIPickerView = UIPickerView()
    var dateToolBar: UIToolbar    = UIToolbar()
    var genreToolBar: UIToolbar   = UIToolbar()
    
    @IBOutlet weak var moviesTableView   : UITableView! 
    @IBOutlet weak var genreButton : UIBarButtonItem!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var moviesViewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = 600
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        genrePicker.delegate = self
        genrePicker.dataSource = self
        moviesViewModel.downloadMovies()
        moviesViewModel.downloadGenres()
        bindVM()
       
    }
    
    private func bindVM() {
        
        moviesViewModel.getMovieList().bind({ [weak self] _ in
        DispatchQueue.main.async {
            self?.moviesTableView.reloadData()
        }
    })
        
    }
}

//MARK:- TableView DataSource and Delegate
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesViewModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CR: move identifier to constant file and follow the constant pattern from weather project
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.MovieCell, for: indexPath) as? MovieCell else {
           return UITableViewCell()
        }
        cell.setUpCellWithModel(movie: (moviesViewModel.getMovie(index: indexPath.row)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "Movie Detail") as? MoviesDetailsViewController {
            
            let movie = moviesViewModel.getMovie(index: indexPath.row)
            movieDetailViewController.viewModel.detailModel = movie
            self.navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
 }
    
}

//MARK:- PickerView DataSource and Delegate
extension MoviesViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return moviesViewModel.getGenreCount() 
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return moviesViewModel.getGenreName(index: row)
    }
}


// Release date filter functions
extension MoviesViewController {
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        if filterButton.title == "Remove Filter" {
            moviesViewModel.resetMoviesList()
            filterButton.title = "Filter"
        }
        else {
           datePicker.isHidden = false
           datePicker.datePickerMode = UIDatePicker.Mode.date
           datePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
           datePicker.backgroundColor = .white
           dateToolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 244, width: UIScreen.main.bounds.size.width, height: 10))
           dateToolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDateDoneButtonTapped))]
           dateToolBar.backgroundColor = .white
           dateToolBar.sizeToFit()
           self.view.addSubview(dateToolBar)
           self.view.addSubview(datePicker)
       }
    }
    
       @objc func onDateDoneButtonTapped() {
        
            dateToolBar.removeFromSuperview()
            datePicker.isHidden = true
            dateToolBar.isHidden = true
            datePicker.removeFromSuperview()
            releaseDateSelected(sender: datePicker)
        }
    
      @objc func releaseDateSelected(sender: UIDatePicker){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let strDate = dateFormatter.string(from: datePicker.date)
            moviesViewModel.releaseDateFilter(date: strDate)
            filterButton.title = "Remove Filter"
       }
    
}

// Genre Filter functions
extension MoviesViewController {
    @IBAction func genreButtonPressed(_ sender: Any) {
        if genreButton.title == "Remove Filter" {
            moviesViewModel.resetMoviesList()
            genreButton.title = "Genre"
        }
        else{
            genrePicker.isHidden = false
            genreToolBar.isHidden = false
            genrePicker.backgroundColor = .white
            genrePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
            genreToolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 244, width: UIScreen.main.bounds.size.width, height: 10))
             genreToolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onGenreDoneButtonTapped))]
             genreToolBar.backgroundColor = .white
             genreToolBar.sizeToFit()
            self.view.addSubview(genreToolBar)
            self.view.addSubview(genrePicker)
        }
    }
    
    @objc func onGenreDoneButtonTapped() {
           genreToolBar.removeFromSuperview()
           genrePicker.isHidden = true
           genreToolBar.isHidden = true
           genrePicker.removeFromSuperview()
           let pickedGenreId = (moviesViewModel.getGenreId(index: genrePicker.selectedRow(inComponent: 0)))
           genreSelected(genreID :pickedGenreId)
    }
    
    @objc func genreSelected(genreID: Int){
        moviesViewModel.genreFilter(genreID: genreID)
        genreButton.title = "Remove Filter"
    }
}
