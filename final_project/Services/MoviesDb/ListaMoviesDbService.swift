//
//  ListaMuviesDbService.swift
//  final_project
//
//  Created by wellington martins on 06/07/23.
//

import Foundation

protocol ListaMoviewsDbServiceType {
     
     func getFavoritos(completion: @escaping (Result<[MovieListDb], ApiError>) -> Void)
}

class ListaMoviesDbService: ListaMoviewsDbServiceType {
     
     let url: String = "http://localhost:3000/api/series"
     let bearerToken = access_token ?? String()
     
     func getFavoritos(completion: @escaping (Result<[MovieListDb], ApiError>) -> Void) {
          
          guard let url = URL(string: self.url) else {
               completion(.failure(.invalidURL))
               return
          }
          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
          
          URLSession.shared.dataTask(with: request) { (data, response, error) in
               if let error = error {
                    completion(.failure(.failedRequest))
                    return
               }
               guard let data = data else {
                    completion(.failure(.noData))
                    return
               }
               guard let movieListDb = try? JSONDecoder().decode([MovieListDb].self, from: data) else {
                    completion(.failure(.invalidData))
                    return
               }
               completion(.success(movieListDb))
               
          }.resume()

     }
     
}
