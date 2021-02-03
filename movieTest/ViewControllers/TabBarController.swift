//
//  ViewController.swift
//  movieTest
//
//  Created by User on 01.12.2020.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeTab()
    }
    
    func makeTab() {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        
        guard let listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
        
        let listVC = UINavigationController(rootViewController: listViewController)
        listVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        guard let favouriteViewController = storyboard.instantiateViewController(withIdentifier: "FavouritesViewController") as? FavouritesViewController else { return }
        
        let favouriteVC = UINavigationController(rootViewController: favouriteViewController)
        favouriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        viewControllers = [listVC, favouriteVC]
    }
}

