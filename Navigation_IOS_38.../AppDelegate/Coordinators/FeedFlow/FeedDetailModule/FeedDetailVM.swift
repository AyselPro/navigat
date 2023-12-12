//
//  FeedDetailVM.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 12.12.2023.
//

import Foundation

protocol FeedDetailVM {
    var onClose: Action? { get set }
    //var onNext: Action? { get set}
}

class FeedDetailVMImp: FeedDetailVM {
    var onClose: Action?
  //  var onNext: Action?
}

