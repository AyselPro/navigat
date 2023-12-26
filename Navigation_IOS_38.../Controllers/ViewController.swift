//
//  ViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 26.11.2023.
//

import UIKit
import SnapKit
import  iOSIntPackage

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let checkerService = CheckerService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableSupplementaryView( ofKind: "", withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        return cell
    }
    
    @objc func addNewPerson() {
       let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
    
    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }
    
    dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
       let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
       return paths[0]
    }
    
    private func initialize() {
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.image = UIImage(named: "Image")
        avatarImageView.clipsToBounds = true
        view.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(16)
            maker.leading.equalToSuperview ().inset(16)
            maker.width.equalToSuperview().inset(100)
            maker.height.equalToSuperview().inset(100)
        }
        
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Hipster Cat"
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
        view.addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(27)
            maker.leading.equalTo(avatarImageView.trailingAnchor as! ConstraintRelatableTarget).inset(16)
            maker.trailing.equalToSuperview().inset(-16)
        }
        
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
        statusLabel.textColor = .gray
        statusLabel.numberOfLines = 0
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { maker in
            maker.top.greaterThanOrEqualTo(fullNameLabel.bottomAnchor as! ConstraintRelatableTarget).inset(10)
            maker.leading.equalTo(avatarImageView.trailingAnchor as! ConstraintRelatableTarget).inset(16)
            maker.trailing.equalToSuperview().inset(-16)
            maker.bottom.equalTo(avatarImageView)
        }
        
        let statusTextField = UITextField()
        statusTextField.borderStyle = .roundedRect
        statusTextField.placeholder = "Set your status..."
        view.addSubview(statusTextField)
        statusTextField.snp.makeConstraints { maker in
            maker.top.equalTo(statusLabel.bottomAnchor as! ConstraintRelatableTarget).inset(5)
            maker.leading.equalTo(statusLabel)
            maker.trailing.equalTo(statusLabel)
            maker.height.equalToSuperview().inset(34)
        }
        
        let setStatusButton = UIButton()
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.setTitleColor(UIColor.white, for: .normal)
        setStatusButton.setTitleColor(UIColor.red, for: .focused)
        setStatusButton.setTitleColor(UIColor.red, for: .highlighted)
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.layer.cornerRadius = 4
        view.addSubview(setStatusButton)
        setStatusButton.snp.makeConstraints { maker in
            maker.top.equalTo(statusTextField.bottomAnchor as! ConstraintRelatableTarget).inset(16)
            maker.leading.equalToSuperview().inset(16)
            maker.trailing.equalToSuperview().inset(-16)
            maker.bottom.equalToSuperview().inset(-10)
        }
//            setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
    
//    @objc func buttonPressed(_sender: UIButton) {
//        let vc = LogInViewController()
//        present(vc, animated: true)
//    }
//
    
    //1
    let color = UIColor(named: "#4885CC")
    
    
//    //5
//    @objc private func tapBurButtonItamAction() {
//        let LogInViewController = LogInViewController()
//        navigationController?.pushViewController(LogInViewController, animated: true)
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
