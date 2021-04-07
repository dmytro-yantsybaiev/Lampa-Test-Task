//
//  SearchViewController.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 04.04.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private var searchedMovieData: MovieData?
    private var searchTableRows = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        searchTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "ReusableMovieCell")

        
    }
}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let movieName = searchBar.text {
            NetworkManager().fetchSearchResult (movieName: movieName) { [weak self] (movieData) in
                self?.searchedMovieData = movieData
                let capacity = movieData.results.capacity
                if capacity > 20 {
                    self?.searchTableRows = 20
                } else {
                    self?.searchTableRows = capacity
                }
                DispatchQueue.main.async {
                    self?.searchTableView.reloadData()
                }
            }
        }
        searchBar.endEditing(true)
    }
}

//MARK: - Section Heading

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTableRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableMovieCell", for: indexPath) as! MovieCell
        updateCellUI(cell: cell, index: indexPath.row)
        return cell
    }

    func updateCellUI(cell: MovieCell, index: Int) {
        let result = searchedMovieData?.results[index]
        cell.titleLabel.text = result?.title
        cell.overviewLabel.text = result?.overview
        cell.releaseDateLabel.text = result?.release_date
        if let posterPath = result?.poster_path {
            cell.movieImageView.loadImage(from: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!)
        }
    }
}
