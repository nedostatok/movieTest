//
//  StoreService.swift
//  movieTest
//
//  Created by User on 04.12.2020.
//

import Foundation
import CoreData
import UIKit

final class StoreService {
    static let shared = StoreService()
    private init() {}
    
    func createMovie(movie: Movie) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let description = NSEntityDescription.entity(forEntityName: "Favourite", in: context)!
        let favouriteObject = NSManagedObject(entity: description, insertInto: context)
        
        favouriteObject.setValue(movie.id, forKey: "id")
        favouriteObject.setValue(movie.releaseDate, forKey: "releaseDate")
        favouriteObject.setValue(movie.title, forKey: "title")
        favouriteObject.setValue(movie.overview, forKey: "overview")
        favouriteObject.setValue(movie.posterPath, forKey: "posterPath")
        favouriteObject.setValue(movie.genreIDS, forKey: "genreIds")
        
        do {
            try context.save()
        } catch {
            print("create failed")
        }
    }
    
    func getMovie() -> [Favourite] {
        var favourites = [Favourite]()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        
        do {
            favourites  = try context.fetch(request)
        } catch {
            print("read failed")
        }
        return favourites
    }
}
