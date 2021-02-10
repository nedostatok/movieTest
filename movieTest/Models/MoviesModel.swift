//
//  MoviesModel.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let genreIDS: [Int]?
    let id: Int?
    let overview: String?
    let posterPath, releaseDate, title: String?

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
