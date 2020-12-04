//
//  MoviesModel.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import Foundation

enum ResponseEnum<T> {
    case Error(NSError)
    case Value(T)
    
}

struct Movies: Decodable {
    let results: [Result]
    
}

// MARK: - Result
struct Result: Decodable {
  //  let genreIDS: [Int]
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String

}

