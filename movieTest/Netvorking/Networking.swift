//
//  Networking.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    typealias HandleForMovieList = (Result<Movies,Error>) -> ()
    typealias HandleForGenreName = (Result<Genres,Error>) -> ()
    
    func getMoviesList(completion: @escaping HandleForMovieList) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=ecde1313ab4f7f72fb55ae39b128564a&language=en-US&page=1") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                let taskError = NSError(domain: "", code: ErrorCode.taskError.rawValue, userInfo: nil)
                completion(.failure(taskError))
                return
            }
            
            guard let data = data else {
                let emptyData = NSError(domain: "", code: ErrorCode.emptyData.rawValue, userInfo: nil)
                completion(.failure(emptyData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Movies.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                let parseError = NSError(domain: "", code: ErrorCode.parseError.rawValue, userInfo: nil)
                completion(.failure(parseError))
            }
        }.resume()
    }
    
    func getMovieGenreName(completion: @escaping HandleForGenreName){
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=ecde1313ab4f7f72fb55ae39b128564a&language=en-US") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, respons, error) in
            
            guard error == nil else {
                let taskError = NSError(domain: "", code: ErrorCode.taskError.rawValue, userInfo: nil)
                completion(.failure(taskError))
                return
            }
            
            guard let data = data else {
                let emptyData = NSError(domain: "", code: ErrorCode.emptyData.rawValue, userInfo: nil)
                completion(.failure(emptyData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Genres.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                let parseError = NSError(domain: "", code: ErrorCode.parseError.rawValue, userInfo: nil)
                completion(.failure(parseError))
            }
        }.resume()
    }
}

