//
//  FeedVC.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 12.12.2023.
//

import UIKit

class FeedVC: UIViewController {
    
    let viewModel: FeedVM
    
   // var coordinator: FeedBaseCoordinator?
    
    private lazy var goToFeed2button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Go to Detail", for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(goToFeed2), for: .touchUpInside)
        return btn
    }()
    
    init(viewModel: FeedVM) {
        self.viewModel = viewModel
       // self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        title = "Feed"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        setupUI()
    }
    
    private func  setupUI() {
        view.addSubview(goToFeed2button)
        
        NSLayoutConstraint.activate([
            goToFeed2button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToFeed2button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func goToFeed2() {
        viewModel.onNext?()
    }
    
}
