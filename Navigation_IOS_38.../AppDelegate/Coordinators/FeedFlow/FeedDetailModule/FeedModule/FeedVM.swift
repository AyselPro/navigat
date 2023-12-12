//
//  FeedVM.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 12.12.2023.
//

import Foundation

protocol FeedVM {
    var onNext: Action? { get set }
}
//инплиментейшен
class FeedVMImp: FeedVM {
    var onNext: Action?
}
