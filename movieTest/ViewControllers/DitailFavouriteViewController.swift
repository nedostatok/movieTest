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
    @IBOutlet weak var ganre: UILabel!
    
    var selected: Favourite?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeInterface()
    }
    
    func customizeInterface() {
        name.text = selected?.title
        
        guard  let posterPath = selected!.posterPath,
               let url = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)") else { return }
        
        posterImage.load(url: url)
    }
}
