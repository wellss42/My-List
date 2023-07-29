//
//  MoviesListController.swift
//  final_project
//
//  Created by wellington martins on 06/07/23.
//

import Foundation
import UIKit

class MoviesListDbController: UIViewController, Coordinating {
     
     var coordinator: Coordinator?
     lazy var viewModel: MoviesDbViewModel = {
          let viewModel = MoviesDbViewModel(service: ListaMoviesDbService())
          viewModel.delegate = self
          return viewModel
     }()
     
     // BIND GET SETUP
     private var data: [MovieListDb] = []
     
     private var collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collectionView.backgroundColor = .black
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          return collectionView
     }()
     
     private func didTapCell(position: IndexPath) {
          coordinator?.navigate(to: .moviesDetailsDb(movie: data[position.row]), data: nil)
     }
     
     override func viewDidLoad() {
          self.view.backgroundColor = .black
          super.viewDidLoad()
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.register(MoviesImageCell.self, forCellWithReuseIdentifier: "MoviesImageCell")
          setup()
          // BIND ASK DATA
          viewModel.getMoviesDb()
     }
     
     // BIND VIEW - REACTIVE RELOAD FROM VIEW MODEL
     func reloadTable() {
         DispatchQueue.main.async {
             self.collectionView.reloadData()
         }
         
     }
}

extension UIImageView {
    func loadImage3(from urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}

extension MoviesListDbController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     
     // MARK: - Data source methods
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              return data.count
          }

          func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesImageCell", for: indexPath) as! MoviesImageCell
               let image = "https://image.tmdb.org/t/p/w500/" + data[indexPath.row].imagem
              cell.imageView.loadImage3(from: image)
               return cell
          }

          // MARK: - UICollectionViewDelegate methods

          func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               didTapCell(position: indexPath)
          }

          // MARK: - UICollectionViewDelegateFlowLayout methods

          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let width = (collectionView.frame.width - 16) / 2
               let height = width * 1.5
               return CGSize(width: width, height: height)
          }
}

extension MoviesListDbController: MoviesDbViewModelDelegate {
     func presentError(error: String) {
          let alert = UIAlertController(title: "Atenção", message: error, preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          present(alert, animated: true, completion: nil)
     }
     
     func navigateToMoviesList() {
     }
     
     func presentSuccess(success: [MovieListDb]) {
          data = success
          reloadTable()
     }
}

extension MoviesListDbController: ViewCoding {
     
     func buildHierarchy() {
          view.addSubview(collectionView)
     }
     
     func buildConstrantis() {
          NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
               collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
          ])
     }

}
