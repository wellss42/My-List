//
//  LoginViewModel.swift
//  final_project
//
//  Created by wellington martins on 01/07/23.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
     func navigateToMoviesList()
     func presentError(error: String)
}

class LoginViewModel {
     
     weak var delegate: LoginViewModelDelegate?
     private let service: LoginServiceType
    
    init(service: LoginServiceType) {
        self.service = service
    }
    
     func postLogin(dadosLogin: String, dadosSenha: String) {
          service.postLogin(usuario: dadosLogin, senha: dadosSenha) { result in
               DispatchQueue.main.async {
                    switch result {
                    case .success(let loginResponse):
                         self.delegate?.navigateToMoviesList()
                    case .failure(let error):
                         self.delegate?.presentError(error: error.description)
                    }
               }
          }
    }
}

