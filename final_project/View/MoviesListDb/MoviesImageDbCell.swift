//
//  MoviesImageCell.swift
//  final_project
//
//  Created by wellington martins on 10/07/23.
//

import Foundation
import UIKit

class MoviesImageDbCell: UICollectionViewCell {
     
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
     
     
     override init(frame: CGRect) {
          super.init(frame: frame)
          setup()
          setupBounds()
     }
     
     required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
     }
     
}

extension MoviesImageDbCell: ViewCoding {
     
     private func setupBounds() {
          self.layer.cornerRadius = 20.0
          self.layer.borderWidth = 2.0
          self.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          self.tintColor = .black
     }
     
     func buildHierarchy() {
          addSubview(imageView)
     }
     
     func buildConstrantis() {
          NSLayoutConstraint.activate([
               imageView.topAnchor.constraint(equalTo: topAnchor),
               imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
               imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
               imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
          ])
     }
     
}
