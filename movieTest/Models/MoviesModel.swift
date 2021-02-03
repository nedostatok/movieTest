//
//  MoviesModel.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import Foundation

struct Movies: Decodable {
    let results: [Movie]
}

// MARK: - Result
struct Movie: Decodable {
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String

}

