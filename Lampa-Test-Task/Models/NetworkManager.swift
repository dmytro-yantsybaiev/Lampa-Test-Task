//
//  MovieManager.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 05.04.2021.
//

import Foundation
import UIKit

class NetworkManager {
    
    private let apiKey = "f910e2224b142497cc05444043cc8aa4"
    private let popularMovieURL = "https://api.themoviedb.org/3/movie/popular?"
    private let topRatedMovieURL = "https://api.themoviedb.org/3/movie/top_rated?"
    private let searchMovieURL = "https://api.themoviedb.org/3/search/movie?"
    
    func fetchPopularMovie(completionHandler: @escaping (MovieData) -> Void) {
        let movieURL = "\(self.popularMovieURL)api_key=\(self.apiKey)&language=en&page=1"
        performRequest(with: movieURL, completionHandler: completionHandler)
    }
    
    func fetchTopRatedMovie(completionHandler: @escaping (MovieData) -> Void) {
        let movieURL = "\(self.topRatedMovieURL)api_key=\(self.apiKey)&language=en&page=1"
        performRequest(with: movieURL, completionHandler: completionHandler)
    }
    
    func fetchSearchResult(movieName: String, completionHandler: @escaping (MovieData) -> Void) {
        let movieName = movieName.replacingOccurrences(of: " ", with: "+")
        let movieURL = "\(self.searchMovieURL)api_key=\(self.apiKey)&query=\(movieName)"
        performRequest(with: movieURL, completionHandler: completionHandler)
    }

    func performRequest(with url: String, completionHandler: @escaping (MovieData) -> Void) {
        let movieURL = url
        let url = URL(string: movieURL)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            if let data = data,
               let movieData = try? JSONDecoder().decode(MovieData.self, from: data) {
                completionHandler(movieData)
            }
        })
        task.resume()
    }
}

//MARK: - Load UIImageView from URL

extension UIImageView {
    func loadImage(from url: URL) {
        let imageCache = NSCache<AnyObject, UIImage>()
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: url as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
