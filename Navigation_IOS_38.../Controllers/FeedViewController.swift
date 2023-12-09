//
//  FeedViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var post = Post(author: "", description: "", image: "", likes: 0, views: 0)
    
    private let stackView: UIStackView = .init()
    
    var viewModel: FeedModel
    
    // Button for checking word
    private lazy var checkGuessButton: UIButton  = {
        let button = UIButton()
        button.setTitle("Check", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
    private lazy var secretwordTextField: UITextField = {
        let secretwordTextField = UITextField()
        secretwordTextField.placeholder = "Place for password to be checked"
        secretwordTextField.font = UIFont.systemFont(ofSize: 15)
        secretwordTextField.leftView = UIView(frame:
                                                CGRect(
                                                    x: 0,
                                                    y: 0,
                                                    width: 10,
                                                    height: 40
                                                )
        )
        secretwordTextField.layer.cornerRadius = 12
        secretwordTextField.layer.borderWidth = 1
        secretwordTextField.layer.borderColor = UIColor.white.cgColor
        
        return secretwordTextField
    }()
    
    private var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont.boldSystemFont(ofSize: 10)
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .black
        resultLabel.backgroundColor = .systemGray3
        resultLabel.textAlignment = .center
        resultLabel.alpha = 0
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.masksToBounds = true
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return resultLabel
    }()
    
    init(viewModel: FeedModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    private func actionSetStatusButtonPressed() {
        secretwordTextField.endEditing(true)
        
        if secretwordTextField.text != nil && secretwordTextField.text?.count != 0 {
            print("Password sent to server")
            viewModel.check(word: secretwordTextField.text!)
        }
    }
    
    func setup() {
        view.addSubviews(secretwordTextField, checkGuessButton, resultLabel)
        // Constraints
        NSLayoutConstraint.activate([
            
            checkGuessButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -50),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 100),
            
            secretwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secretwordTextField.centerYAnchor.constraint(equalTo: checkGuessButton.topAnchor, constant: -25),
            secretwordTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            secretwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            resultLabel.centerXAnchor.constraint(equalTo: secretwordTextField.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: secretwordTextField.centerYAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 50),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.axis = .vertical
        view.backgroundColor = .lightGray
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        let firstButton = UIButton()
        let secondButton = UIButton()
        
        firstButton.setTitle("Первая кнопка", for: .normal)
        secondButton.setTitle("Вторая кнопка", for: .normal)
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.spacing = 10
        
        firstButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    //true- green
    @objc func trueSelector() {
        print("Password is true")
        
        resultLabel.text = "You've done well!"
        resultLabel.textColor = .green
        resultLabel.layer.borderColor = UIColor.green.cgColor
        resultAnimation()
    }
    //false-red
    @objc func falseSelector() {
        print("Password is false")
        
        resultLabel.text = "Wrong! Try again."
        resultLabel.textColor = .red
        resultLabel.layer.borderColor = UIColor.red.cgColor
        resultAnimation()
    }
    
    func resultAnimation() {
        
    }
    
    @objc private func buttonAction() {
        let postViewController = PostViewController(post: post)
        
        //1
        self.navigationController?.pushViewController(postViewController, animated: true)
        
        //2
        //        postViewController.modalTransitionStyle = .flipHorizontal
        //        postViewController.modalPresentationStyle = .fullScreen
        //        present(postViewController, animated: true)
    }
}


