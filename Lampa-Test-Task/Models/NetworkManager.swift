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
    
    func fetchPopularMovie(for page: Int, completionHandler: @escaping (MovieData) -> Void) {
        let movieURL = "\(self.popularMovieURL)api_key=\(self.apiKey)&language=en&page=\(page)"
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
    
    func fetchTopRatedMovie(for page: Int, completionHandler: @escaping (MovieData) -> Void) {
        let movieURL = "\(self.topRatedMovieURL)api_key=\(self.apiKey)&language=en&page=\(page)"
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
