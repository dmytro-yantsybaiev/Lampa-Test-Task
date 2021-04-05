//
//  Movie.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 04.04.2021.
//

import Foundation

struct MovieData: Codable {
    let page: Int
    let results: [Result]
    let total_pages: Int
    let total_results: Int
}

struct Result: Codable {
    let title: String
    let overview: String
    let release_date: String
    let id: Int
    let poster_path: String
}
