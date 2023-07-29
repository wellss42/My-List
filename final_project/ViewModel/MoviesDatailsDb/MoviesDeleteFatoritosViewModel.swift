//
//  MoviesDetailsDbViewModel.swift
//  final_project
//
//  Created by wellington martins on 08/07/23.


import Foundation

protocol MoviesDeleteDetailsViewModelDelegate: AnyObject  {
     func presentSuccess(success: FavoritarResponse)
     func presentError(error: String)
}

class MoviesDeleteFatoritosViewModel {
     
     weak var delegate: MoviesDeleteDetailsViewModelDelegate?
     private let service: MoviesDetailsDbService
     
     var updateMovieDetails: (() -> Void)?

     init(service: MoviesDetailsDbService) {
          self.service = service
     }
     
     func deleteDetailsDb(id: String) {
          service.deleteDetailsDb(id: id) { result in
               DispatchQueue.main.async {
                    switch result {
                    case .success(let movieListDbResponse):
                         self.delegate?.presentSuccess(success: movieListDbResponse)
                    case .failure(let error):
                         self.delegate?.presentError(error: error.description)
                    }
                    
               }
          }
     }
     
}
