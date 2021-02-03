//
//  FavoriteCell.swift
//  movieTest
//
//  Created by User on 02.12.2020.
//

import UIKit

class FavoriteCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func customizeCell(arr: Favourite) {
        movieName.text = arr.title
        releaseYear.text = arr.releaseDate
        
        guard  let posterPath = arr.posterPath,
               let url = URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)") else { return }
        
        movieImage.load(url: url)
    }
}
