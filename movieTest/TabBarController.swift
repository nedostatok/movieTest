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
        // Do any additional setup after loading the view.
        makeTab()
    }
    
    func makeTab() {
        let storyboard = UIStoryboard(name: "List", bundle: nil)
        
        let listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        
        let listVC = UINavigationController(rootViewController: listViewController)
        listVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let favouriteViewController = storyboard.instantiateViewController(withIdentifier: "FavouritesViewController") as! FavouritesViewController
        
        let favouriteVC = UINavigationController(rootViewController: favouriteViewController)
        favouriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        viewControllers = [listVC, favouriteVC]
    }
}

