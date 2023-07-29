//
//  Coordinator.swift
//  final_project
//
//  Created by Jackson on 23/05/23.
//

import UIKit

enum Routes {
     
     case login
     case moviesList
     case moviesDetails
     case moviesDbList
     case moviesDetailsDb(movie: MovieListDb)
     
}

protocol Coordinator {
    var navigationController:UINavigationController? { get set }
//        var childCoordinators: [Coordinator] { get set }
    
    func start()
    func navigate(to route: Routes, data: Any?)
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
}
