//
//  APICaller.swift
//  News App
//
//  Created by Islomiddin on 24/08/22.
//

import Foundation

final class APICaller {
    
    static let shared = APICaller()
    
    let url = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2022-08-24&sortBy=popularity&apiKey=68c6f28b90954be3a2d528b12997f910")
    let searchURL = "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=68c6f28b90954be3a2d528b12997f910&q="
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard let url = url else { return }
        
        createAndResumeTask(url: url, completion: completion)
    }
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let urlString = searchURL + query
        
        guard let url = URL(string: urlString) else { return }
        
        createAndResumeTask(url: url, completion: completion)
    }
    
    func createAndResumeTask(url: URL, completion: @escaping (Result<[Article], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
