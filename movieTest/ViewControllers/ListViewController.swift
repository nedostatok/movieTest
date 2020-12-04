//
//  ListViewController.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayMovies = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        self.navigationItem.title = "MovieList"
        self.view.backgroundColor = .systemGray
        
        tableView.register(FilmsTableViewCell.self, forCellReuseIdentifier: FilmsTableViewCell.identifier)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(recognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = recognizer.location(in: self.tableView)
            if let index = self.tableView.indexPathForRow(at: touchPoint)  {
                
                let alertController = UIAlertController(title: "AddToFavourites?", message: nil, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Yes", style: .default) { (alert) in
                    
                    let addFavourites = self.arrayMovies[index.row]
                    StoreService.shared.createMovie(movie: addFavourites)
                }
                let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                
                alertController.addAction(alertAction)
                alertController.addAction(cancelAction)
                present(alertController, animated: true)
            }
        }
    }
    
    func fetchData() {
        GetData.shared.getMoviesList { response in
            
            switch response {
            case let .Value(movies):
                self.arrayMovies = movies
                
            case let .Error(error):
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDelegate{}
extension ListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMovies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        
        guard let detailVC = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        
        let selected = arrayMovies[indexPath.row]
        detailVC.selected = selected
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? FilmsTableViewCell else { return UITableViewCell() }
        
        let movie = arrayMovies[indexPath.row]
        
        cell.label.text = movie.title
        return cell
    }
}
