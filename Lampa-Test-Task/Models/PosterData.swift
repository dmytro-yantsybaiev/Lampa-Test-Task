//
//  PosterData.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 05.04.2021.
//

import Foundation

struct PosterData: Codable{
    let id: Int
    let posters: [Poster]
}

struct Poster: Codable {
    let aspect_ratio: Float
    let file_path: String
    let height: Int
    let width: Int
}
