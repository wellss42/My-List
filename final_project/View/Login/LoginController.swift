//
//  loginController.swift
//  final_project
//
//  Created by wellington martins on 26/06/23.
//

import Foundation
import UIKit

class LoginController: UIViewController, Coordinating {
     
     var coordinator: Coordinator?
     lazy var viewModel: LoginViewModel = {
          let viewModel = LoginViewModel(service: LoginService())
          viewModel.delegate = self
          return viewModel
     }()
     
     private lazy var logo: UIImageView = {
          let imagem = UIImageView()
          imagem.image = UIImage(named: Localizable.Login.imagem)
          imagem.translatesAutoresizingMaskIntoConstraints = false
          return imagem
     }()
     
     private lazy var loginLabe: UILabel = {
          let label = UILabel()
          label.text = Localizable.Login.loginLabel
          label.font = UIFont(name: Localizable.Login.fonte, size: 16)
          label.textColor = UIColor.darkGray
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var loginTextField: UITextField = {
          let textField = UITextField()
          textField.backgroundColor = UIColor.black
          textField.layer.cornerRadius = 20.0
          textField.layer.borderWidth = 2.0
          textField.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          textField.font = UIFont(name: Localizable.Login.fonte, size: 16)
          textField.textColor = UIColor.white
          textField.tintColor = UIColor.gray
          
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
          textField.leftView = paddingView
          textField.leftViewMode = .always
          
          let placeholderAttributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: UIColor.gray,
               .font: UIFont(name: Localizable.Login.fonte, size: 16)!
          ]
          textField.attributedPlaceholder = NSAttributedString(string: Localizable.Login.loginTextFildPlaceHolder, attributes: placeholderAttributes)
          textField.translatesAutoresizingMaskIntoConstraints = false
          return textField
     }()
     
     private lazy var senhaLabel: UILabel = {
          let label = UILabel()
          label.text = Localizable.Login.senha
          label.font = UIFont(name: Localizable.Login.fonte, size: 16)
          label.textColor = UIColor.darkGray
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
     }()
     
     private lazy var senhaTextField: UITextField = {
          let textField = UITextField()
          textField.backgroundColor = UIColor.black
          textField.layer.cornerRadius = 20.0
          textField.layer.borderWidth = 2.0
          textField.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          textField.font = UIFont(name: Localizable.Login.fonte, size: 16)
          textField.textColor = UIColor.white
          textField.tintColor = UIColor.gray
          
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
          textField.leftView = paddingView
          textField.leftViewMode = .always
          
          let placeholderAttributes: [NSAttributedString.Key: Any] = [
               .foregroundColor: UIColor.gray,
               .font: UIFont(name: Localizable.Login.fonte, size: 16)!
          ]
          textField.attributedPlaceholder = NSAttributedString(string: Localizable.Login.digiteSuaSenha, attributes: placeholderAttributes)
          
          textField.translatesAutoresizingMaskIntoConstraints = false
          return textField
     }()
     
     private lazy var buttonLogin: UIButton = {
          let button = UIButton()
          button.setTitle(Localizable.Login.acessar, for: .normal)
          button.setTitleColor(.gray, for: .normal)
          button.titleLabel?.textAlignment = .center
          button.backgroundColor = .black
          button.layer.cornerRadius = 20.0
          button.layer.borderWidth = 2.0
          button.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
          button.titleLabel?.font = UIFont(name: Localizable.Login.fonte, size: 16)
          button.tintColor = .gray
          
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
          button.addSubview(paddingView)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.addTarget(self, action: #selector(botaoAcessar), for: .touchUpInside)
          return button
     }()
     
     @objc func botaoAcessar() {
          let login = loginTextField.text ?? String()
          let senha = senhaTextField.text ?? String()
          if login.isEmpty || senha.isEmpty {
               let alert = UIAlertController(title: "Atenção", message: "Preencha todos os campos", preferredStyle: .alert)
               let action = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(action)
               present(alert, animated: true, completion: nil)
               return
          } else {
               viewModel.postLogin(dadosLogin: login.lowercased(), dadosSenha: senha.lowercased())
          }
     }
     
     override func viewDidLoad() {
          view.backgroundColor = .black
          super.viewDidLoad()
          setup()
          //Não esquecer de tirar
          loginTextField.text = "admin"
          senhaTextField.text = "123456"
     }
     
}

extension LoginController: LoginViewModelDelegate {
     
     func presentError(error: String){
          let alert = UIAlertController(title: "Atenção", message: error, preferredStyle: .alert)
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(action)
          present(alert, animated: true, completion: nil)
     }
     
     func navigateToMoviesList() {
          coordinator?.navigate(to: .moviesList, data: nil)
     }
     
}

extension LoginController: ViewCoding {
     
     func buildHierarchy() {
          view.addSubview(logo)
          view.addSubview(loginLabe)
          view.addSubview(loginTextField)
          view.addSubview(senhaLabel)
          view.addSubview(senhaTextField)
          view.addSubview(buttonLogin)
     }
     
     func buildConstrantis() {
          
          NSLayoutConstraint.activate([
               logo.heightAnchor.constraint(equalToConstant: 130),
               logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
               logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               logo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               
               loginLabe.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 80),
               loginLabe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
               
               loginTextField.heightAnchor.constraint(equalToConstant: 50),
               loginTextField.topAnchor.constraint(equalTo: loginLabe.bottomAnchor, constant: 12),
               loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               
               senhaLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
               senhaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               senhaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               
               senhaTextField.heightAnchor.constraint(equalToConstant: 50),
               senhaTextField.topAnchor.constraint(equalTo: senhaLabel.bottomAnchor, constant: 12),
               senhaTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               senhaTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               
               buttonLogin.heightAnchor.constraint(equalToConstant: 50),
               buttonLogin.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
               buttonLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               buttonLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
          ])

     }
     
}
