//
//  MovieManager.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 05.04.2021.
//

import Foundation
import UIKit

protocol MovieManagerDelegate {
    func didUpdateMovieData(_ movieManager: MovieManager, movie: MovieModel)
    func didFailUpdateMovieData(error: Error)
}

struct MovieManager {
    
    var delegate: MovieManagerDelegate?
    var movieIndex = 0
    
    private let apiKey = "f910e2224b142497cc05444043cc8aa4"
    private let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?"
    private let topRatedMovieURL = "https://api.themoviedb.org/3/movie/top_rated?"
    private let posterURL = "https://image.tmdb.org/t/p/w500"
    
    mutating func fetchPopularMovie(page: Int, movieIndex: Int) {
        self.movieIndex = movieIndex
        let movieURL = "\(popularMovieURL)api_key=\(apiKey)&language=en&page=\(page)"
        performRequest(with: movieURL)
    }
    
    mutating func fetchTopRatedMovie(page: Int, movieIndex: Int) {
        self.movieIndex = movieIndex
        let movieURL = "\(topRatedMovieURL)api_key=\(apiKey)&language=en&page=\(page)"
        performRequest(with: movieURL)
    }

    private func performRequest(with movieURL: String) {
        // Create a URL
        if let url = URL(string: movieURL) {
            
            // Create a URLSession
            let session = URLSession(configuration: .default)
            
            // Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailUpdateMovieData(error: error!)
                } else {
                    if let safeData = data {
                        if let movie = parseJSON(movieData: safeData) {
                            delegate?.didUpdateMovieData(self, movie: movie)
                        }
                    }
                }
            }
            
            // Start the task
            task.resume()
        }
    }
    
    private func parseJSON(movieData: Data) -> MovieModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            
            let movie = MovieModel(title: decodedData.results[movieIndex].title, overview: decodedData.results[movieIndex].overview, release_date: decodedData.results[movieIndex].release_date, posterPath: "\(posterURL)\(decodedData.results[movieIndex].poster_path)")
            return movie
        } catch {
            delegate?.didFailUpdateMovieData(error: error)
            return nil
        }
    }
    
//    private func parseJSON(posterData: Data) ->
}
