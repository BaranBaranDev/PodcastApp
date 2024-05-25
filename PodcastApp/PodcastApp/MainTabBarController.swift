//
//  MainTabBarController.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: - Helpers
extension MainTabBarController {
    // Tab bar'ı oluşturma ve özelleştirme fonksiyonu
    private func setup() {
        // Tab bar'a eklenecek view controller'ları oluştur
        let searchVC = createViewController(rootVC: SearchBuilder.build(), title: "Search", image: "magnifyingglass.circle")
        let favoriteVC = createViewController(rootVC: FavoriteVC(), title: "Favorite", image: "star.circle")
        let downloadVC = createViewController(rootVC: Download(), title: "Download", image: "arrow.down.circle")
        
        // Oluşturulan view controller'ları tab bar'a ekle
        viewControllers = [searchVC, favoriteVC, downloadVC]
        
        // Tab bar'ı ve navigation bar'ı özelleştir
        customizeTabBar()
        customizeNavigationBar()
    }
    
    // Her view controller için UINavigationController oluşturma fonksiyonu
    private func createViewController(rootVC: UIViewController, title: String, image: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: rootVC)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        
        // View controller başlığını ayarlama
        rootVC.title = title
        
        return controller
    }
    
    // Tab bar'ı özelleştirme fonksiyonu
    private func customizeTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.backgroundColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    // Navigation bar'ı özelleştirme fonksiyonu
    private func customizeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
}

// MARK: - VC


final class FavoriteVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
    }
}

final class Download: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
}

