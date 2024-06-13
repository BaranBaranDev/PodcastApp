//
//  AppDelegate.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//
//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Baran Baran on 30.05.2024.
//

import UIKit
import CoreData
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let vc = MainTabBarController()
        window?.rootViewController = vc
        
        // SDImageCache konfigürasyonunu yap
        let cacheConfig = SDImageCache.shared.config
        cacheConfig.maxDiskSize = 20 * 1024 * 1024  // 20 MB
        
        // Bellek (RAM) önbelleği için ek ayarlar
        cacheConfig.maxMemoryCost = 10 * 1024 * 1024  // 10 MB
        cacheConfig.maxMemoryCount = 20  // Maksimum 20 görsel
        

        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PodcastApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
