//
//  ProfileViewController.swift
//  Navigation_IOS_38
//
//  Created by Aysel on 11.09.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    
    let profileHeaderView: ProfileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(profileHeaderView)
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0
        
        let height = view.frame.height - topPadding - bottomPadding
        
        profileHeaderView.frame = CGRect(x: 0, y: topPadding, width: view.frame.width, height: height)
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
