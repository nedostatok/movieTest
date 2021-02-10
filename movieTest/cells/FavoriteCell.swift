//
//  FavoriteCell.swift
//  movieTest
//
//  Created by User on 02.12.2020.
//

import UIKit

class FavoriteCell: UITableViewCell {
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private var releaseYear: UILabel!
    
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
