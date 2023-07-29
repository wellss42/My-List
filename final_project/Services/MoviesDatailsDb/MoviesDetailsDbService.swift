//
//  MoviesDetailsDbService.swift
//  final_project
//
//  Created by wellington martins on 08/07/23.
//

import Foundation

protocol MoviesDetailsDbServiceDelegate {
     func getDetailsDb (id: String, completion: @escaping (Result<FavoritarResponse, ApiError>) -> Void)
     func editDetailsDb(id: String, title: String, pontuacaoMedia: String, totalVotos: String, imagem: String, completion: @escaping (Result<FavoritarResponse, ApiError>) -> Void)
}

class MoviesDetailsDbService {
     
     let url: String = "http://localhost:3000/api/series/"
     let bearerToken = access_token ?? String()
     
     func deleteDetailsDb(id: String, completion: @escaping (Result<FavoritarResponse, ApiError>) -> Void){
          
          guard let url = URL(string: self.url + id) else {
               completion(.failure(.invalidURL))
               return
          }
          
          print("Token: \(bearerToken)")
          var request = URLRequest(url: url)
          request.httpMethod = "DELETE"
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
               guard let movieListDbResponse = try? JSONDecoder().decode(FavoritarResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
               }
               completion(.success(movieListDbResponse))
               
          }.resume()
          
     }
     
     func editDetailsDb(id: String, title: String, sinopse: String, pontuacaoMedia: String, totalVotos: String, imagem: String, imagemDeFundo: String,completion: @escaping (Result<FavoritarResponse, ApiError>) -> Void){
          
          guard let url = URL(string: self.url + id) else {
               completion(.failure(.invalidURL))
               return
          }
          var request = URLRequest(url: url)
          request.httpMethod = "PUT"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
          
          let parameters = ["title": title, "sinopse": sinopse, "pontuacaoMedia": pontuacaoMedia, "totalVotos": totalVotos, "imagem": imagem, "imagemDeFundo": imagemDeFundo]
          
          guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
               completion(.failure(.invalidParameters))
               return
          }
          
          request.httpBody = jsonData
          
          URLSession.shared.dataTask(with: request) { (data, response, error) in
               if let error = error {
                    completion(.failure(.failedRequest))
                    return
               }
               guard let data = data else {
                    completion(.failure(.noData))
                    return
               }
               guard let movieListDbResponse = try? JSONDecoder().decode(FavoritarResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
               }
               completion(.success(movieListDbResponse))
               
          }.resume()
          
     }
     
}
