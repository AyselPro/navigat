//
//  ProfileVM.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 11.12.2023.
//

import Foundation

protocol ProfileVM {
    var onDetail: Action? { get set }
}
//инплиментейшен
class ProfileVMImp: ProfileVM {
    var onDetail: Action?
}
