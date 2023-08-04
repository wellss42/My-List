//
//  MoviesDetailsController.swift
//  final_project
//
//  Created by Jackson on 16/08/22.
//

import Foundation
import UIKit

class MovieDetailsController: UIViewController, Coordinating {
     
     var coordinator: Coordinator?
//     var viewModel: MovieDetailsViewModel?
     var movieId: String
     
     lazy var viewModel: MovieDetailsViewModel = {
          let viewModel = MovieDetailsViewModel(model: MovieDetailsModel())
          return viewModel
     }()
     
     
     private lazy var uiView: UIView = {
          let uiView = UIView()
          uiView.backgroundColor = .black
          uiView.layer.cornerRadius = 20.0
          uiView.layer.borderWidth = 2.0
          uiView.translatesAutoresizingMaskIntoConstraints = false
          return uiView
     }()
     
     private lazy var uiView2: UIView = {
          let uiView = UIView()
          uiView.backgroundColor = .black
          uiView.layer.cornerRadius = 20.0
          uiView.layer.borderWidth = 2.0
          uiView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          uiView.translatesAutoresizingMaskIntoConstraints = false
          return uiView
     }()
     
     let imageView: UIImageView = {
          let imageView = UIImageView()
          imageView.contentMode = .scaleAspectFill
          imageView.clipsToBounds = true
          imageView.layer.cornerRadius = 20.0
          imageView.layer.borderWidth = 2.0
          imageView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          imageView.translatesAutoresizingMaskIntoConstraints = false
          return imageView
     }()
     
     private lazy var mainTitle: UILabel = {
          let label = UILabel()
          label.text = movie?.title
          label.textAlignment = .center
          label.font = .boldSystemFont(ofSize: 18)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var voteAverage: UILabel = {
          let label = UILabel()
          label.text = String(movie?.voteAverage ?? 0.0)
          label.font = .boldSystemFont(ofSize: 16)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     
     private lazy var voteCount: UILabel = {
          let label = UILabel()
          label.text = String(movie?.voteCount ?? 0)
          label.font = .boldSystemFont(ofSize: 16)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var summary: UILabel = {
          let label = UILabel()
          label.text = String(movie?.voteCount ?? 0)
          label.numberOfLines = 0
          label.font = .boldSystemFont(ofSize: 16)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var spinner: UIActivityIndicatorView = {
          let view = UIActivityIndicatorView()
          view.style = .large
          view.translatesAutoresizingMaskIntoConstraints = false
          view.startAnimating()
          return view
     }()
     
     var movie: MovieDetails? {
          return viewModel.movie
     }
     
     init(movieId: String) {
          self.movieId = movieId
          super.init(nibName: nil, bundle: nil)
          super.viewDidLoad()
     }
     
     required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
          self.view.backgroundColor = .black
          setup()
          bindSetup()
     }
     
     func updateScreen() {
          DispatchQueue.main.async { [weak self] in
               self?.fetchImage(imageURL: String(self!.viewModel.movie?.backdropPath ?? ""))
               self?.mainTitle.text = self?.viewModel.movie?.title ?? ""
               self?.voteAverage.text = "Pontuação Média: \(String(self?.viewModel.movie?.voteAverage ?? 0.0))"
               self?.voteCount.text = "Total de votos: \(String(self?.viewModel.movie?.voteCount ?? 0))"
               self?.summary.text = "Sinopse: \(self?.viewModel.movie?.overview ?? "")"
          }
     }
     
     private func fetchImage(imageURL: String) {
          let image = "https://image.tmdb.org/t/p/w500"
         guard let url = URL(string: image + imageURL) else {
             // Tratamento de erro caso a URL seja inválida
             return
         }
         URLSession(configuration: .default).dataTask(with: url) { data, response, error in
             if let error = error {
                 // Tratamento de erro caso ocorra um erro na requisição
                 print("Erro ao carregar imagem: \(error.localizedDescription)")
                 return
             }
             DispatchQueue.main.async {
                 if let data = data, let dataImage = UIImage(data: data) {
                     self.imageView.image = dataImage
                 } else {
                     // Tratamento de erro caso os dados da imagem sejam inválidos
                     print("Erro ao carregar imagem: dados inválidos")
                 }
             }
         }.resume()
     }
     
     func showLoading() {
          view.addSubview(spinner)
          
          spinner.heightAnchor.constraint(equalToConstant: 200).isActive = true
          spinner.widthAnchor.constraint(equalToConstant: 200).isActive = true
          spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
     }
     
     func hideLoading() {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               self.spinner.removeFromSuperview()
          }
     }
}

extension MovieDetailsController: ViewCoding {
     
     func bindSetup() {
          viewModel = MovieDetailsViewModel(model: MovieDetailsModel())
          viewModel.updateMovieDetails = updateScreen
          viewModel.fetchMovie(movieId: movieId)
     }
     
     func buildHierarchy() {
          self.view.addSubview(uiView)
          self.uiView.addSubview(uiView2)
          self.uiView2.addSubview(imageView)
          self.uiView2.addSubview(mainTitle)
          self.uiView2.addSubview(voteAverage)
          self.uiView2.addSubview(voteCount)
          self.uiView2.addSubview(summary)

     }
     
     func buildConstrantis() {
          NSLayoutConstraint.activate([
               
               uiView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
               uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
               uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
               uiView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5),
               
               uiView2.topAnchor.constraint(equalTo: uiView.safeAreaLayoutGuide.topAnchor, constant: 10),
               uiView2.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
               uiView2.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
               
               imageView.topAnchor.constraint(equalTo: uiView2.topAnchor, constant: 10),
               imageView.leadingAnchor.constraint(equalTo: uiView2.leadingAnchor, constant: 10),
               imageView.trailingAnchor.constraint(equalTo: uiView2.trailingAnchor, constant: -10),
               
               mainTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
               mainTitle.leadingAnchor.constraint(equalTo: uiView2.leadingAnchor),
               mainTitle.trailingAnchor.constraint(equalTo: uiView2.trailingAnchor),
               
               voteAverage.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 16),
               voteAverage.leadingAnchor.constraint(equalTo: uiView2.leadingAnchor, constant: 20),
               voteAverage.trailingAnchor.constraint(equalTo: uiView2.trailingAnchor, constant: -20),
               
               voteCount.topAnchor.constraint(equalTo: voteAverage.bottomAnchor, constant: 16),
               voteCount.leadingAnchor.constraint(equalTo: uiView2.leadingAnchor, constant: 20),
               voteCount.trailingAnchor.constraint(equalTo: uiView2.trailingAnchor, constant: -20),
               
               summary.topAnchor.constraint(equalTo: voteCount.bottomAnchor, constant: 16),
               summary.leadingAnchor.constraint(equalTo: uiView2.leadingAnchor, constant: 20),
               summary.trailingAnchor.constraint(equalTo: uiView2.trailingAnchor, constant: -20)
               
          ])
     }
     
     
}

