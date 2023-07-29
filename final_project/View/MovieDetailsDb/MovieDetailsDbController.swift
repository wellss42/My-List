//
//  MovieDetailsDbController.swift
//  final_project
//
//  Created by wellington martins on 08/07/23.
//

import Foundation
import UIKit

class MovieDetailsDbController: UIViewController, Coordinating {
     
     var coordinator: Coordinator?
     let movie: MovieListDb
     
     lazy var deleteViewModel: MoviesDeleteFatoritosViewModel = {
          let viewModel = MoviesDeleteFatoritosViewModel(service: MoviesDetailsDbService())
          viewModel.delegate = self
          return viewModel
     }()
     
     lazy var editViewModel: MoviesEditFatoritosViewModel = {
          let viewModel = MoviesEditFatoritosViewModel(service: MoviesDetailsDbService())
          viewModel.delegate = self
          return viewModel
     }()
     
     private lazy var uiView: UIView = {
          let uiView = UIView()
          uiView.backgroundColor = .black
          uiView.layer.cornerRadius = 20.0
          uiView.layer.borderWidth = 2.0
          uiView.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor
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
          label.text = String()
          label.textAlignment = .center
          label.font = .boldSystemFont(ofSize: 18)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var voteAverage: UILabel = {
          let label = UILabel()
          label.text = String()
          label.font = .boldSystemFont(ofSize: 16)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     
     private lazy var voteCount: UILabel = {
          let label = UILabel()
          label.text = String()
          label.font = .boldSystemFont(ofSize: 16)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var summary: UILabel = {
          let label = UILabel()
          label.text = String()
          label.numberOfLines = 0
          label.font = .boldSystemFont(ofSize: 16)
          label.textColor = .white
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var stackButton: UIStackView = {
          let stack = UIStackView(arrangedSubviews: [buttonEditar, buttonDeletar])
          stack.axis = .horizontal
          stack.distribution = .fillEqually
          stack.alignment = .fill
          stack.spacing = 10
          stack.translatesAutoresizingMaskIntoConstraints = false
          return stack
     }()
     
     private lazy var buttonEditar: UIButton = {
          let button = UIButton()
          button.setTitle("Editar", for: .normal)
          button.setTitleColor(.gray, for: .normal)
          button.titleLabel?.textAlignment = .center
          button.backgroundColor = .black
          button.layer.cornerRadius = 20.0
          button.layer.borderWidth = 2.0
          button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
          button.tintColor = .gray
          
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
          button.addSubview(paddingView)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.addTarget(self, action: #selector(editarButton), for: .touchUpInside)
          return button
     }()
     
     private lazy var buttonDeletar: UIButton = {
          let button = UIButton()
          button.setTitle("Deletar", for: .normal)
          button.setTitleColor(.gray, for: .normal)
          button.titleLabel?.textAlignment = .center
          button.backgroundColor = .black
          button.layer.cornerRadius = 20.0
          button.layer.borderWidth = 2.0
          button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
          button.tintColor = .gray
          
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
          button.addSubview(paddingView)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.addTarget(self, action: #selector(deletarButton), for: .touchUpInside)
          return button
     }()
     
     @objc private func editarButton() {
         let alert = UIAlertController(title: "Adicione novo título", message: nil, preferredStyle: .alert)
         
         alert.addTextField { textField in
             textField.placeholder = "Novo título"
         }
         
          let okAction = UIAlertAction(title: "Alterar", style: .default) { [self, weak alert] _ in
             guard let textField = alert?.textFields?.first, let newTitle = textField.text else {
                 return
             }
               
               self.editViewModel.editDetailsDb(id: String(self.movie.id), title: newTitle, sinopse: self.movie.sinopse, pontuacaoMedia: String(self.movie.pontuacaoMedia), totalVotos: String(self.movie.totalVotos), imagem: self.movie.imagem, imagemDeFundo: self.movie.imagemDeFundo)
             
         }
         
         alert.addAction(okAction)
         present(alert, animated: true, completion: nil)
     }
     
     @objc private func deletarButton(){
          deleteViewModel.deleteDetailsDb(id: String(movie.id))
     }
     
     init(movie: MovieListDb) {
          self.movie = movie
          super.init(nibName: nil, bundle: nil)
     }
     
     required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
          self.view.backgroundColor = .black
          super.viewDidLoad()
          setup()
          updateScreens()
     }
     
     func updateScreens(){
          DispatchQueue.main.async { [weak self] in
               self?.fetchImage(imageURL:  self?.movie.imagemDeFundo ?? "")
               self?.mainTitle.text = "\(Localizable.Details.titulo) \(self?.movie.title ?? "")"
               self?.voteAverage.text = "\(Localizable.Details.pontuacaoMedia) \(String(self?.movie.pontuacaoMedia ?? 0.0))"
               self?.voteCount.text = "\(Localizable.Details.totalVotor) \(String(self?.movie.totalVotos ?? 0))"
               self?.summary.text = "\(Localizable.Details.sinopse) \(self?.movie.sinopse ?? "")"
          }
     }
     
     private func fetchImage(imageURL: String) {
          let image = "https://image.tmdb.org/t/p/w500/"
         guard let url = URL(string: image + imageURL) else {
             return
         }
         URLSession(configuration: .default).dataTask(with: url) { data, response, error in
             if let error = error {
                 print("Erro ao carregar imagem: \(error.localizedDescription)")
                 return
             }
             DispatchQueue.main.async {
                 if let data = data, let dataImage = UIImage(data: data) {
                     self.imageView.image = dataImage
                 } else {
                     print("Erro ao carregar imagem: dados inválidos")
                 }
             }
         }.resume()
     }
     
}

extension MovieDetailsDbController: MoviesDeleteDetailsViewModelDelegate {
     
     func presentSuccess(success: FavoritarResponse) {
          coordinator?.navigate(to: .moviesList, data: nil)
     }
     
     func presentError(error: String){
          let alert = UIAlertController(title: "Atenção", message: error, preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          present(alert, animated: true, completion: nil)
     }
     
}

extension MovieDetailsDbController: MoviesEditViewModelDelegate {
     
     func editSuccess(success: FavoritarResponse) {
          coordinator?.navigate(to: .moviesList, data: nil)
     }
     
     func editError(error: String){
          let alert = UIAlertController(title: "Atenção", message: error, preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          present(alert, animated: true, completion: nil)
     }
}

extension MovieDetailsDbController: ViewCoding {
     
     func buildHierarchy() {
          self.view.addSubview(uiView)
          self.uiView.addSubview(uiView2)
          self.uiView2.addSubview(imageView)
          self.uiView2.addSubview(mainTitle)
          self.uiView2.addSubview(voteAverage)
          self.uiView2.addSubview(voteCount)
          self.uiView2.addSubview(summary)
          self.uiView.addSubview(stackButton)

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
               summary.trailingAnchor.constraint(equalTo: uiView2.trailingAnchor, constant: -20),
               
               stackButton.heightAnchor.constraint(equalToConstant: 50),
               stackButton.topAnchor.constraint(equalTo: uiView2.bottomAnchor, constant: 10),
               stackButton.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
               stackButton.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
               stackButton.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: -10)
               
          ])
          
     }
     
}
