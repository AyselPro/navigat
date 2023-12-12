//
//  ProfileDetailVM.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 11.12.2023.
//

import Foundation

protocol ProfileDetailVM {
    var onClose: Action? { get set }
   // var onNext: Action? { get set}
}

class ProfileDetailVMImp: ProfileDetailVM {
    var onClose: Action?
  //  var onNext: Action?
}
