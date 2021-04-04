//
//  Movie.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 04.04.2021.
//

import Foundation

struct Movie {
    let page: Int
    let results: [Result]
    let total_pages: Int
    let total_results: Int
}

struct Result {
    let poster_path: String?
    let adult: Bool
    let overview: String
    let release_date: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String?
    let popularity: Float
    let vote_count: Int
    let video: Bool
    let vote_average: Float
}
