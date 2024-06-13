//
//  FavoriteRouter.swift
//  PodcastApp
//
//  Created by Baran Baran on 13.06.2024.



import UIKit

protocol FavoriteRoutingLogic {
  
}

protocol FavoriteDataPassing {
  var dataStore: FavoriteDataStore? { get }
}



final class FavoriteRouter:  FavoriteDataPassing {
    
  weak var controller: FavoriteViewController?
  var dataStore: FavoriteDataStore?

}



extension FavoriteRouter: FavoriteRoutingLogic {
    
}
