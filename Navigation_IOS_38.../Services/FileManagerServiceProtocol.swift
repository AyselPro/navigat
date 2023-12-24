//
//  FileManagerServiceProtocol.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 21.12.2023.
//

import UIKit

protocol  FileManagerServiceDelegate: AnyObject {
    
    var items: [String] { get }
}
