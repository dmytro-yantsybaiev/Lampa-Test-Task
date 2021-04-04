//
//  SearchViewController.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 04.04.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
}
