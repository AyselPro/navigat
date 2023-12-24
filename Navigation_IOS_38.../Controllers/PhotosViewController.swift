//
//  PhotosViewController.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 05.10.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    private var imageCollection: [UIImage] = []
    private let spasing = 8.0
    private let count = 3.0
    
    var imagePublisherFacade: ImagePublisherFacade?
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spasing
        layout.minimumInteritemSpacing = spasing
        layout.sectionInset = UIEdgeInsets(top: spasing, left: spasing, bottom: spasing, right: spasing)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupView()
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Photo Gallery"
        
        imagePublisherFacade?.subscribe(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            
            imagePublisherFacade?.removeSubscription(for: self)
        
            imagePublisherFacade?.rechargeImageLibrary()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

//MARK: - Extensions
extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let value = imageCollection[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fullSpasing = (count + 1) * spasing // 32
        let widthCollectionView = collectionView.bounds.width
        let width = (widthCollectionView - fullSpasing) / count
        
        return CGSize(width: width, height: width)
    }

}

//
extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        self.imageCollection = images
    }
    
}
