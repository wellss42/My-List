//
//  LoginService.swift
//  final_project
//
//  Created by wellington martins on 01/07/23.
//

import Foundation

var access_token: String!

protocol LoginServiceType {
     func postLogin(usuario: String, senha: String, completion: @escaping (Result<LoginResponse, ApiError>) -> Void)
}

class LoginService: LoginServiceType {
     
     let url: String = "http://localhost:3000/seg/login"
     
     func postLogin(usuario: String, senha: String, completion: @escaping (Result<LoginResponse, ApiError>) -> Void) {
          guard let url = URL(string: self.url) else {
               completion(.failure(.invalidURL))
               return
          }
          
          var request = URLRequest(url: url)
          request.httpMethod = "POST"
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          
          let parameters = ["login": usuario, "senha": senha]
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
               guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
               }
               completion(.success(loginResponse))
               access_token = loginResponse.token
               
          }.resume()
     }
     
}


