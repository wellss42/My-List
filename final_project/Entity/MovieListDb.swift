//
//  MovieListDb.swift
//  final_project
//
//  Created by wellington martins on 06/07/23.
//

import Foundation

struct MovieListDb: Codable {
     
     let id: Int
     let title: String
     let sinopse: String
     let pontuacaoMedia: Double
     let totalVotos: Float
     let imagem: String
     let imagemDeFundo: String
}

