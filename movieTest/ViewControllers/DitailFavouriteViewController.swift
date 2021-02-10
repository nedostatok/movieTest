//
//  DitailFavouriteViewController.swift
//  movieTest
//
//  Created by User on 02.12.2020.
//

import UIKit

class DitailFavouriteViewController: UIViewController {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    var selected: Favourite?
    var genreId = [Genre]() {
        didSet {
            gettingGenreName()
        }
    }    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeInterface()
        fetchGenre()
    }
    
    func fetchGenre() {
        NetworkService.shared.getMovieGenreName { response in
            switch response {
            case let .success(genres):
                self.genreId = genres.genres

            case let .failure(error):
                print(error)
            }
        }
    }
    
    func gettingGenreName() {
        guard let selected = self.selected?.genreIds as? [Int] else { return }
        var stringArray = [String]()
        for i in genreId {
            for d in selected {
                if i.id == d {
                    let name = i.name
                    stringArray.append(name)
                }
            }
        }
        let totalNames = stringArray.joined(separator: ",")
        DispatchQueue.main.async {
            self.genreLabel.text = totalNames
        }
            
    }
    
    func customizeInterface() {
        guard let title = selected?.title,
              let poster = selected?.posterPath else { return }
        
        name.text = title
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(poster)") else { return }
        
        posterImage.load(url: url)
    }
}
