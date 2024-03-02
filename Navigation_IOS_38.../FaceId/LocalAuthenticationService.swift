//
//  LocalAuthenticationService.swift
//  Navigation_IOS_38_Ganbarova
//
//  Created by Aysel on 02.03.2024.
//

import LocalAuthentication

protocol LocalAuthenticationService {
    var biometryType: LABiometryType { get }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void)
}

final class LocalAuthenticationServiceImpl: LocalAuthenticationService {
    private let context = LAContext()
    
    var biometryType: LABiometryType {
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        return context.biometryType
    }

    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return authorizationFinished(false, NSError(domain: "BiometryNotAvailable", code: 0))
        }
        
        let reason = "Идентифицируйте себя"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
            authorizationFinished(success, error)
        }
    }
}
