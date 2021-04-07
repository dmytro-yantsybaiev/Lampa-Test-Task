//
//  SearchViewController.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 04.04.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var movieManager = MovieManager()
    var movies: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    
}

//MARK: - MovieManagerDelegate

//extension SearchViewController: MovieManagerDelegate {
//    
//    func didUpdateMovieData(_ movieManager: MovieManager, movie: MovieModel) {
//        <#code#>
//    }
//    
//    func didFailUpdateMovieData(error: Error) {
//        <#code#>
//    }
//    
//    
//}

//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
}
