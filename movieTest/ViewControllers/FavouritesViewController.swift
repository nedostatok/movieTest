//
//  FavouritesViewController.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import UIKit
import CoreData

class FavouritesViewController: UIViewController {
    let tableView = UITableView()
    
    var arrayFafourites = [Favourite]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeInterface()
        addLongPress()
        setupDelegateForTableView()
    }
    
    func setupDelegateForTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func customizeInterface() {
        self.navigationItem.title = "Favourites"
        self.view.backgroundColor = .systemGray
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        arrayFafourites = StoreService.shared.getMovie()
    }
    
    func addLongPress() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(recognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = recognizer.location(in: tableView)
            if let index = self.tableView.indexPathForRow(at: touchPoint) {
                createAlertAndRemoveFavorite(index: index)
            }
        }
    }
    
    func createAlertAndRemoveFavorite(index: IndexPath) {
        let alertController = UIAlertController(title: "Remove?", message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            let removeFavourites = self.arrayFafourites[index.row]
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(removeFavourites)
            self.arrayFafourites.remove(at: index.row)
            
            do {
                try context.save()
                self.tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        self.tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

extension FavouritesViewController: UITableViewDelegate{}
extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFafourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoriteCell else { return UITableViewCell() }
        let favourites = arrayFafourites[indexPath.row]
        
        cell.customizeCell(arr: favourites)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        let selected = arrayFafourites[indexPath.row]
        
        guard let detailFavVC = storyboard.instantiateViewController(identifier: "DitailFavouriteViewController") as? DitailFavouriteViewController else { return }
        
        detailFavVC.selected = selected
        navigationController?.pushViewController(detailFavVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
