//
//  FireBaseLoginViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 17.10.2023.
//

import UIKit

final class FireBaseLoginViewController: UIViewController {
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.placeholder = "Email of phone"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
        stackView.layer.borderWidth = 0.5
        view.clipsToBounds = true
        
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .disabled)

        button.addTarget(self, action: #selector(logInButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var singUpButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Sing Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .disabled)

        button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "Logo")
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    private let service: CheckerServiceProtocol
    
    init(service: CheckerServiceProtocol) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.loadView()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        logInButton.backgroundColor = UIColor(named: "Blue")
        singUpButton.backgroundColor = UIColor(named: "Blue")?.withAlphaComponent(0.5)
        
        setupConstraints()
        title = "Profile"
    }
    
    @objc private func logInButtonDidTap() {
        guard
            let login = emailTextField.text,
            let password = passwordTextField.text,
            !login.isEmpty,
            !password.isEmpty
        else {
            return showAlert(title: "Ошибка!", message: "Не введены поля")
        }
        
        service.checkCredentials(email: login, password: password) { [weak self] isSuccess in
            if isSuccess {
                self?.showAlert(title: "Успешно!", message: "Пользователь залогинен")
                self?.emailTextField.text = nil
                self?.passwordTextField.text = nil
            } else {
                self?.showAlert(title: "Ошибка!", message: "Такого пользователя не существует")
            }
        }
    }
    
    @objc private func signUpButtonDidTap() {
        guard
            let login = emailTextField.text,
            let password = passwordTextField.text,
            !login.isEmpty,
            !password.isEmpty
        else {
            return showAlert(title: "Ошибка!", message: "Не введены поля")
        }
        
        service.signUp(email: login, password: password) { [weak self] isSuccess in
            if isSuccess {
                self?.showAlert(title: "Успешно!", message: "Пользователь зарегистрирован")
                self?.emailTextField.text = nil
                self?.passwordTextField.text = nil
            } else {
                self?.showAlert(title: "Ошибка!", message: "Ошибка на стороне FireBase")
            }
        }
    }
    
    private func setupConstraints() {
        let content = UIView()
        let scrollView = UIScrollView()
        let contentView = UIView()
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        let imageView = UIImageView(image: .init(named: "Logo"))
        
        view.addSubviews(content)
        content.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(imageView, stackView, logInButton, singUpButton)
        
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            content.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            content.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: content.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 120),
            
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            singUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            singUpButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -50),
            singUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            singUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            singUpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Закрыть", style: .cancel)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
    
    private func errorCatched(error : String, errorMessage: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: error, message: errorMessage, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ОК...", style: .default) { _ in
                print(error)
            }
            alertController.addAction(okAction)
            
        }
    }
}
