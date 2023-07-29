//
//  MoviesDbViewModel.swift
//  final_project
//
//  Created by wellington martins on 06/07/23.
//

import Foundation

protocol MoviesDbViewModelDelegate: AnyObject {
     func navigateToMoviesList()
     func presentSuccess(success: [MovieListDb])
     func presentError(error: String)
}

class MoviesDbViewModel {
     
     weak var delegate: MoviesDbViewModelDelegate?
     private let service: ListaMoviesDbService
    
    init(service: ListaMoviesDbService) {
         self.service = service
    }
     
     func getMoviesDb() {
          service.getFavoritos { result in
               DispatchQueue.main.async {
                    switch result {
                    case .success(let movieListDb):
                         self.delegate?.presentSuccess(success: movieListDb)
                    case .failure(let error):
                         self.delegate?.presentError(error: error.description)
                    }
               }
          }
    
     }
     
}
