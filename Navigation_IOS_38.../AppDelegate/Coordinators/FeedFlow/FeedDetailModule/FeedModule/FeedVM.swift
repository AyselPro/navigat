//
//  FeedVM.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 12.12.2023.
//

import Foundation

protocol FeedVM {
    var view: FeedViewControllerDelegate? { get set }
    func searchText(_ text: String?)
    var onNext: Action? { get set }
}
//инплиментейшен
class FeedVMImp: FeedVM {
    weak var view: FeedViewControllerDelegate?
    private let model: FeedModel = .init()
    
    var onNext: Action?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkWord(_:)), name: FeedModel.key, object: nil)
    }
    
    
    @objc private func checkWord(_ notification: NSNotification) {
        guard let object = notification.object as? Bool else { return }
        object ? view?.trueSelector() : view?.falseSelector()
    }
    
    func searchText(_ text: String?) {
        guard let text = text, !text.isEmpty else { return }
        model.check(word: text)
    }
}
