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
    
    var selected: Favourite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeInterface()
    }
    
    func customizeInterface() {
        guard let title = selected?.title, let poster = selected?.posterPath else { return }
        name.text = title
        guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(poster)") else { return }
        
        posterImage.load(url: url)
    }
}
