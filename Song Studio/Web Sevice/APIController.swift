//
//  APIController.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import Foundation
import Network

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}


struct APIController {
    
    func dataTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, CustomError>) -> ()) {
//        
//        guard NetworkStatus.shared.isConnected else {
//            return completion(.failure(.networkError))
//        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
                return
            }
            
            guard let data = data else { return }
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                
                print("\n\n======================================================================\n\n")
                print("\(T.self) ----------\n\n \(responseData)")
                print("\n\n======================================================================\n\n")
                
                completion(.success(responseData))
            }
            catch let error {
                print("decode error: ", error)
                completion(.failure(.error(error.localizedDescription)))
            }
            
            }.resume()
    }
    
}


public enum CustomError: Error {
    case networkError
    case error(String)
}

extension CustomError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("noNetwork", comment: "noNetwork")
        case .error(let error):
            return error
        }
    }
    
}

