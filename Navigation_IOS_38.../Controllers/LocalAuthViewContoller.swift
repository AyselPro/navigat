//
//  LocalAuthViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 02.03.2024.
//

import UIKit

final class LocalAuthViewController: UIViewController {
    
    private let button = UIButton()
    private let textLabel = UILabel()
    private let authService: LocalAuthenticationService
    
    init(authService: LocalAuthenticationService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(textLabel)
        setUpSubviews()
        setUpLayout()
    }
    
    private func setUpSubviews() {
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.text = "Авторизация по FaceID"
        
        switch authService.biometryType {
        case .none:
            button.setImage(nil, for: .normal)
        case .faceID:
            button.setImage(UIImage(systemName: "face.smiling"), for: .normal)
        case .touchID:
            button.setImage(UIImage(systemName: "hand.raised.fingers.spread"), for: .normal)
        @unknown default:
            button.setImage(nil, for: .normal)
        }
        
        button.setTitle("Пройти авторизацию", for: .normal)
        button.configuration = .borderedTinted()
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
    }
    
    private func setUpLayout() {
        button.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                textLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                button.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8)
            ]
        )
    }
    
    @objc
    private func buttonDidTapped() {
        authService.authorizeIfPossible { [weak self] success, error  in
            guard let self else { return }
            DispatchQueue.main.async {
                if success, error == nil {
                    self.textLabel.text = "Авторизация прошла успешно!"
                    self.textLabel.textColor = .systemGreen
                } else if let error {
                    self.textLabel.text = "Произошла ошибка: \(error.localizedDescription)"
                    self.textLabel.textColor = .systemRed
                } else {
                    self.textLabel.text = "Произошла ошибка"
                    self.textLabel.textColor = .systemRed
                }
            }
        }
    }
}
