//
//  MoviesService.swift
//  final_project
//
//  Created by Jackson on 22/05/23.
//

import Foundation

protocol MoviesServiceType {
    func getMovies(completion: @escaping (Data?, Error?) -> Void) -> Void
}

class MoviesService: MoviesServiceType {
    let uri: String = "https://api.themoviedb.org/3/movie"
    let topRatedEndpoint: String = "/top_rated"
    let apiKey: String = "1657dcb8e27eadc93b81987e08474436"
    
    func getMovies(completion: @escaping (Data?, Error?) -> Void) -> Void {
        let url = "\(uri)\(topRatedEndpoint)?api_key=\(apiKey)"
         print(url)
        
        URLSession.shared.dataTask(with: URL(string: url)!,
           completionHandler: { (data, response, error) in
                completion(data, error)
            }
        ).resume()
    }
}
