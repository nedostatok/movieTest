//
//  Networking.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import Foundation

struct NetworkService {
    static let shared = NetworkService()
    private let jsonDecoder = Utils.jsonDecoder
    typealias HandleForMovieList = (Result<[Movie],Error>) -> ()
    
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
                let decodedResponse = try self.jsonDecoder.decode(Movies.self, from: data)
                var movieArray = [Movie]()
                
                for i in decodedResponse.results {
                    let overview = i.overview
                    let posterPath = i.posterPath
                    let releaseDate = i.releaseDate
                    let title = i.title
                    let id = i.id
                    
                    movieArray.append(Movie(id: id, overview: overview, posterPath: posterPath, releaseDate: releaseDate, title: title))
                }
                completion(.success(movieArray))
            } catch {
                let parseError = NSError(domain: "", code: ErrorCode.parseError.rawValue, userInfo: nil)
                completion(.failure(parseError))
            }
        }.resume()
    }
}

final class Utils {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}
