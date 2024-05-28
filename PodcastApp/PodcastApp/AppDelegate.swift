//
//  AppDelegate.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarController()
        
        // SDImageCache konfigürasyonunu yap
        let cacheConfig = SDImageCache.shared.config
        cacheConfig.maxDiskSize = 50 * 1024 * 1024  // 50 MB
       // cacheConfig.maxDiskAge = 3 * 24 * 60 * 60 // 3 gün
        
        // Bellek (RAM) önbelleği için ek ayarlar
        cacheConfig.maxMemoryCost = 30 * 1024 * 1024  // 30 MB
        cacheConfig.maxMemoryCount = 100  // Maksimum 100 görsel

        return true
    }


}

