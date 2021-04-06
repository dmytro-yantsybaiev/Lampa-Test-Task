//
//  PopularMovieCell.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 04.04.2021.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    private var movieManager = MovieManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieManager.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getPopular(page: Int, movieIndex: Int) -> MovieCell {
        movieManager.fetchPopularMovie(page: page, movieIndex: movieIndex)
        return self
    }
    
    func getTopRated(page: Int, movieIndex: Int) -> MovieCell {
        movieManager.fetchTopRatedMovie(page: page, movieIndex: movieIndex)
        return self
    }
}

//MARK: - MovieManagerDelegate

extension MovieCell: MovieManagerDelegate {
    
    func didUpdateMovieData(_ movieManager: MovieManager, movie: MovieModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            self.releaseDateLabel.text = "Release date: \(movie.release_date)"
            if let posterPath = movie.posterPath {
                self.movieImageView.loadImage(from: URL(string: posterPath)!)
            }
        }
    }
    
    func didFailUpdateMovieData(error: Error) {
        print(error)
    }
}
