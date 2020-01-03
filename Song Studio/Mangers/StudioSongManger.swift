//
//  StudioSongManger.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import Foundation

class StudioSongManager {
    
    let apiController = APIController()
    typealias FetchCompletion = (Result<[Song], CustomError>)
    
    
    func getSongs(_ completionHandler : @escaping (FetchCompletion) -> ()) {
        
        let url = APIManager().url(withParameters: nil, Endpoints.studio)
        
        guard let urlRequest = APIManager().requestUrl(url, method: "GET", header: nil, data: nil) else { return }
        
        apiController.dataTask(request: urlRequest) { (result: FetchCompletion) in
            
            switch result {
                
            case .success(let songs):
                completionHandler(.success(songs))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
