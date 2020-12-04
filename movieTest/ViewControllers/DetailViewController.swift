//
//  DetailViewController.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    var selected: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeInterface()
    }
    
    func customizeInterface() {
        movieYear.text = selected?.releaseDate
        movieDescription.text = selected?.overview
        guard  let posterPath = selected?.posterPath,
               let url = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)") else { return }
        
        movieImage.load(url: url)
    }
}

extension UIImageView {
    func load(url: URL) {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = CGPoint(x:self.frame.width/2,
                                           y: self.frame.height/2)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        activityIndicator.stopAnimating()
                        activityIndicator.isHidden = true
                    }
                }
            }
        }
    }
}
