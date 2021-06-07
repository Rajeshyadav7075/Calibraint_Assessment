//
//  APICallManager.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 01/06/21.
//

import Foundation

class APICallManager {
        
    var url: String?
        
//    http://api.tvmaze.com/search/shows?q=netflix
//    https://api.tvmaze.com/shows/12567
//    http://api.tvmaze.com/shows/12567?embed=episodes
    
    func fetchDataFromServer<T: Decodable>(type: T.Type = T.self,url: String, completionHandler: @escaping (Result<T,Error>) -> ()) {
    
        
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
    
            guard let data = data,let statusCode = response as? HTTPURLResponse else {
                return
            }
            print("Response: \(statusCode.statusCode)")
            
            do {
                
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                
                DispatchQueue.global().async {
                    completionHandler(.success(jsonData))
                }
            } catch let error {
                completionHandler(.failure(error))
            }
            
        }
        task.resume()
    }
    
}
