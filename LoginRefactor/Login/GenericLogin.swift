//
//  GenericLogin.swift
//  LoginRefactor
//
//  Created by Maola Ma on 20/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//

import Foundation

enum LoginChoice: String {
    case Email
    case Google
    case Facebook
}

typealias loginCompletion = (Result<User, Error>) -> Void
protocol LoginProtocol: class {
    func requestLogin(completion: @escaping loginCompletion)
}


class LoginFactory {
    func create(for type: LoginChoice) -> LoginProtocol {
        switch type {
        case .Google:
           return GoogleLogin()
        case .Facebook:
           return FacebookLogin()
        default:
            return EmailLogin()
        }
    }
}
