//
//  FavoritarViewModel.swift
//  final_project
//
//  Created by wellington martins on 05/07/23.
//

import Foundation

protocol FavoritarViewModelDelegate: AnyObject {
     func presentSuccess(success: String)
     func presentError(error: String)
}

class FavoritarViewMode {
     
     weak var delegate: FavoritarViewModelDelegate?
     private let service: FavoritarServiceType
     
     init(service: FavoritarServiceType) {
          self.service = service
     }
     
     func postFavoritar(title: String, sinopse: String,pontuacaoMedia: String, totalVotos: String, imagem: String, imagemDeFundo: String){
          service.postFavoritar(title: title, pontuacaoMedia: pontuacaoMedia, totalVotos: totalVotos, sinopse: sinopse, imagem: imagem, imagemDeFundo: imagemDeFundo) { result in
               DispatchQueue.main.sync {
                    switch result {
                    case .success(let favoriteResponse):
                         print(favoriteResponse.message)
                         self.delegate?.presentSuccess(success: String(favoriteResponse.message))
                    case .failure(let error):
                         self.delegate?.presentError(error: error.description)
                    }
               }
          }
     }
     
}
