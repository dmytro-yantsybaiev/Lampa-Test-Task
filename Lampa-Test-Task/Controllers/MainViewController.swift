//
//  ViewController.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 03.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var storiesTabButton: UIButton!
    @IBOutlet weak var videoTabButton: UIButton!
    @IBOutlet weak var favouritesTabButton: UIButton!
    @IBOutlet weak var tabsScrollView: UIScrollView!
    @IBOutlet weak var mainTableView: UITableView!
    
    private lazy var tabButtons = [storiesTabButton, videoTabButton, favouritesTabButton]
    
    private var popularMoviesData: MovieData?
    private var resultPage = 1
    private var mainTableRows = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabsScrollView.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(UINib(nibName: "TopRatedMovieCell", bundle: nil), forCellReuseIdentifier: "ReusableTopRatedMovieCell")
        mainTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "ReusableMovieCell")
        
        NetworkManager().fetchPopularMovie(for: resultPage) { [weak self] (movieData) in
            self?.popularMoviesData = movieData
            self?.mainTableRows = movieData.results.capacity - 3
            DispatchQueue.main.async {
                self?.mainTableView.reloadData()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func tabButtonPressed(_ sender: UIButton) {
        setAllTabButtonsCollorGray()
        setSelectedTabButtonCollorWhite(sender)
        
        UIView.animate(withDuration: 0.2) {
            self.changeScrollViewPositionToSelectedTab(sender)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "goToSearch" {
        //            let searchVC = segue.destination as! SearchViewController
        //        }
    }
    
    func setAllTabButtonsCollorGray() {
        for tabButton in tabButtons {
            tabButton?.setTitleColor(.gray, for: .normal)
        }
    }
    
    func setSelectedTabButtonCollorWhite(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
    }
    
    func changeScrollViewPositionToSelectedTab(_ tabButton: UIButton) {
        let currentTabPage = CGFloat(tabButtons.firstIndex(of: tabButton)!)
        tabsScrollView.contentOffset.x = view.frame.width * currentTabPage
    }
}

//MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x/view.frame.width))
        setAllTabButtonsCollorGray()
        setSelectedTabButtonCollorWhite(tabButtons[pageIndex]!)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableRows + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTopRatedMovieCell", for: indexPath) as! TopRatedMovieCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableMovieCell", for: indexPath) as! MovieCell
            updateCellUI(cell: cell, index: indexPath.row - 1)
            return cell
        }
    }
    
    func updateCellUI(cell: MovieCell, index: Int) {
        let result = popularMoviesData?.results[index]
        cell.titleLabel.text = result?.title
        cell.overviewLabel.text = result?.overview
        cell.releaseDateLabel.text = result?.release_date
        if let posterPath = result?.poster_path {
            cell.movieImageView.loadImage(from: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!)
        }
    }
}
