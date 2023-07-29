//
//  ViewController.swift
//  final_project
//
//  Created by Jackson on 11/08/22.
//

import UIKit

// MARK: - Main Class

class MoviesListController: UIViewController, Coordinating {
     
     var coordinator: Coordinator?
     private var viewModel: MoviesViewModel!
     
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
     
     private var collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
          collectionView.backgroundColor = .black
          collectionView.translatesAutoresizingMaskIntoConstraints = false
          return collectionView
     }()
     
     private lazy var button: UIButton = {
          let button = UIButton()
          button.setTitle("Favoritos", for: .normal)
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
          button.addTarget(self, action: #selector(favoritos), for: .touchUpInside)
          return button
     }()
     
     @objc private func favoritos() {
          coordinator?.navigate(to: .moviesDbList, data: nil)
     }
     
     // BIND GET SETUP
     private var data: [Movies] {
          return viewModel.model.movies
     }
     
     // MARK: - Initialize
     
     override func viewDidLoad() {
          self.view.backgroundColor = .black
          super.viewDidLoad()
          collectionView.delegate = self
          collectionView.dataSource = self
          collectionView.register(MoviesImageCell.self, forCellWithReuseIdentifier: "MoviesImageCell")
          setup()
          bindSetup()
          // BIND ASK DATA
          viewModel.getMovies()
     }

     private func didTapCell(position: IndexPath) {
          let id = String(data[position.row].id)
          coordinator?.navigate(to: .moviesDetails, data: id)
     }
     
     func reloadTable() {
          DispatchQueue.main.async {
               self.collectionView.reloadData()
          }
     }
}

extension UIImageView {
    func loadImage(from urlString: String) {
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

extension MoviesListController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
     
     // MARK: - Data source methods
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
              return data.count
          }

          func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesImageCell", for: indexPath) as! MoviesImageCell
              let image = "https://image.tmdb.org/t/p/w500" + data[indexPath.row].posterPath
              cell.imageView.loadImage(from: image)
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

extension MoviesListController: ViewCoding {
     
     private func bindSetup() {
          viewModel = MoviesViewModel(movies: MoviesModel(), service: MoviesService())
          viewModel.reloadTable = self.reloadTable
     }
     
     func buildHierarchy() {
          self.view.addSubview(uiView)
          self.uiView.addSubview(uiView2)
          self.uiView2.addSubview(collectionView)
          self.uiView.addSubview(button)
     }
     
     func buildConstrantis() {
          NSLayoutConstraint.activate([
          uiView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
          uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
          uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
          uiView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
          
          uiView2.topAnchor.constraint(equalTo: uiView.safeAreaLayoutGuide.topAnchor, constant: 10),
          uiView2.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
          uiView2.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
          
          collectionView.topAnchor.constraint(equalTo: uiView2.topAnchor, constant: 10),
          collectionView.leadingAnchor.constraint(equalTo: uiView2.leadingAnchor, constant: 10),
          collectionView.trailingAnchor.constraint(equalTo: uiView2.trailingAnchor, constant: -10),
          collectionView.bottomAnchor.constraint(equalTo: uiView2.bottomAnchor, constant: -10),
          
          button.heightAnchor.constraint(equalToConstant: 50),
          button.topAnchor.constraint(equalTo: uiView2.bottomAnchor, constant: 10),
          button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
          button.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
          button.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10)
          ])
     }
}

