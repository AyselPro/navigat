//
//  FeedDetailVC.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 12.12.2023.
//

import UIKit

class FeedDetailVC: UIViewController {
    
    let viewModel: FeedDetailVM
    
    private lazy var goToFavoriteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Go to feed tab", for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.backgroundColor = .black
        btn.addTarget(self, action: #selector(goToFeedTab), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    init(viewModel: FeedDetailVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Detail Feed"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.addSubviews(goToFavoriteButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .systemPurple
        setupUI()
    }
    
    @objc private func goToFeedTab() {
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}
