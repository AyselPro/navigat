//
//  ProfileHeaderView.swift
//  Navigation_IOS_38
//
//  Created by Aysel on 13.09.2023.
//

import UIKit

final class ProfileHeaderView: UIView {
    private let imageView = UIImageView()
    private let catNameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let showStatusButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        setupView()
        setupShadow()
        setupActionButton()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCornerRadius()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func setupCornerRadius() {
        let height = imageView.frame.height / 2
        imageView.layer.cornerRadius = height
    }
    
    
    private func setupShadow() {
        let newColor = UIColor.black
        showStatusButton.layer.shadowColor = newColor.cgColor
        showStatusButton.layer.masksToBounds = true
        showStatusButton.clipsToBounds = false
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowRadius = 4
        showStatusButton.layer.shadowOpacity = 0.7
    }
    
    private func setupActionButton() {
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc private func buttonPressed () {
        let text = descriptionLabel.text
        print(text)
    }
    
    
    private func setupView() {
        self.addSubview(imageView)
        self.addSubview(catNameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(showStatusButton)
        
        imageView.backgroundColor = .red
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.image = UIImage(named: "Image")
        imageView.clipsToBounds = true
        
        catNameLabel.text = "Hipster Cat"
        catNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        catNameLabel.textColor = .black
        
        descriptionLabel.text = "Waiting for something..."
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 0
        
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.setTitleColor(UIColor.white, for: .normal)
        showStatusButton.setTitleColor(UIColor.red, for: .focused)
        showStatusButton.setTitleColor(UIColor.red, for: .highlighted)
        showStatusButton.setTitle("Show status", for: .normal)
        showStatusButton.layer.cornerRadius = 4
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        catNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        
            catNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            catNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            catNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        
            descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: catNameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        
            showStatusButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            showStatusButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 34)
        ])
    }
}

