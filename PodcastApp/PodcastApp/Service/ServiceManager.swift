//
//  ServiceManager.swift
//  PodcastApp
//
//  Created by Baran Baran on 25.05.2024.
//

import Foundation
import Alamofire

protocol ServiceManagerProtocol {
    func fetchData<T: Decodable>(url : String, completion: @escaping(Result<T, Error>) -> Void)
}

final class ServiceManager{
    static let shared = ServiceManager()
    private init(){}
}


extension ServiceManager: ServiceManagerProtocol{
    func fetchData<T: Decodable>(url : String, completion: @escaping(Result<T, Error>) -> Void){
        AF.request(url).validate().responseDecodable(of: T.self) { [weak self] response in
            guard self != nil else {return }
            switch response.result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
