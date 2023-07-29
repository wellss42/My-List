//
//  FavoritarService.swift
//  final_project
//
//  Created by wellington martins on 05/07/23.
//

import Foundation

protocol FavoritarServiceType {
     
     func postFavoritar(title: String, pontuacaoMedia: String, totalVotos: String, sinopse: String, imagem: String, imagemDeFundo: String, completion: @escaping (Result<FavoritarResponse, ApiError>) -> Void)
     
}

class FavoritarService: FavoritarServiceType {
     
     let url: String = "http://localhost:3000/api/series"
     let bearerToken = access_token ?? String()
     
     func postFavoritar(title: String, pontuacaoMedia: String, totalVotos: String, sinopse: String, imagem: String, imagemDeFundo: String, completion: @escaping (Result<FavoritarResponse, ApiError>) -> Void) {
          
          guard let url = URL(string: self.url) else {
               completion(.failure(.invalidURL))
               return
          }
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
          
          let pontuacaoMediaDecimal = Double(pontuacaoMedia) ?? 0.0
          let totalVotosInt = Int(totalVotos) ?? 0

          let parameter = [
              "title": title,
              "sinopse": sinopse,
              "pontuacaoMedia": pontuacaoMediaDecimal,
              "totalVotos": totalVotosInt,
              "imagem": imagem,
              "imagemDeFundo": imagemDeFundo
          ] as [String : Any]
          
          print(parameter)

          guard let jsonData = try? JSONSerialization.data(withJSONObject: parameter) else {
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
               guard let favoritarResponse = try? JSONDecoder().decode(FavoritarResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
               }
               completion(.success(favoritarResponse))
               
          }.resume()
     }
     
}
