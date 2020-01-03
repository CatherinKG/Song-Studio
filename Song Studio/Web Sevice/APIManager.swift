//
//  APIManager.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import Foundation

enum Environment {
    
    case development
    case release
    
    var scheme : String {
        switch self {
        case .development:
            return "http"
        case .release:
            return "http"
        }
    }
    
    var host: String {
        switch self {
        case .development:
            return "starlord.hackerearth.com"
        case .release:
            return "starlord.hackerearth.com"
        }
    }
    
}

struct Endpoints {
    static let studio = "studio"
    
}


struct APIEnvironment {
    
    static let environment: Environment = .release
}


struct APIManager {
    
    let environment = APIEnvironment.environment
    
    func createUrl(withScheme scheme: String, _ host: String, _ path: String, _ parameters: [String: Any]?) -> URL? {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItem(Parameters: parameters)
        return components.url
    }
    
    
    func url(withParameters parameter: [String: Any]?, _ endpoint: String)  -> URL? {
        
        return createUrl(withScheme: environment.scheme, environment.host, String(format: "/%@", endpoint), parameter)
        
    }
    
    func queryItem(Parameters dict: [String: Any]? ) -> [URLQueryItem]? {
        
        guard let parameters = dict else { return nil }
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            
            queryItems.append(URLQueryItem(name: key, value: String(describing: value)))
        }
        
        return queryItems
    }
    
    func requestUrl(_ url: URL?, method: String, header: [String: Any]?, data: [String: Any]? ) -> URLRequest? {
        guard let url = url else { return nil}
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        do {
            if method == "POST" {
                guard let data =  data else {
                    return nil
                }
                let jsonData: Data = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpBody = jsonData
            }
            
            if let keyList = header?.keys {
                for item in keyList {
                    request.setValue(header![item] as? String, forHTTPHeaderField: item)
                }
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = TimeInterval(120)
            return request
            
            
        }
        catch let error{
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}
