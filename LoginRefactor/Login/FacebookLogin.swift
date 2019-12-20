//
//  FacebookLogin.swift
//  LoginRefactor
//
//  Created by Maola Ma on 20/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

typealias loginCompletion = (Result<User, Error>) -> Void

protocol LoginProtocol: class {
    func requestLogin(completion: @escaping (Result<User, Error>) -> Void)
}


class FacebookLogin: LoginProtocol {
    
    deinit {
        print("Deallocing \(self)")
    }
    
    func requestLogin(completion: @escaping loginCompletion) {
        guard AccessToken.current == nil else {
            self.getFbUserInfo() { (error, user) in
                if let error = error {
                    completion(.failure(NSError(domain: error, code: 0, userInfo: nil)))
                } else if let user = user {
                    completion(.success(user))
                }
            }
            return
        }
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ "public_profile" ]) {[weak self] (loginResult) in
            guard let self = self else { return }
            switch loginResult {
            case .failed(let error):
                completion(.failure(error))
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                if grantedPermissions.contains("email") && grantedPermissions.contains("public_profile") {
                    self.getFbUserInfo() { (error, user) in
                        if let error = error {
                            completion(.failure(NSError(domain: error, code: 0, userInfo: nil)))
                        } else if let user = user {
                            completion(.success(user))
                        }
                    }
                }
            }
        }
    }
    
    
    /// Fetch user data from the server using FB access token
    private func getFbUserInfo(completion: @escaping (String?, User?)-> Void) {
        guard AccessToken.current != nil else {
            return
        }
        
        let myGraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, birthday, age_range, picture.width(400), gender"], tokenString: AccessToken.current?.tokenString, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
        
        myGraphRequest.start(completionHandler: { (connection, result, error) in
            if let res = result {
                let responseDict = res as! [String:Any]
                let firstName = responseDict["first_name"] as! String
                completion(nil, User(name: firstName))
            } else {
                completion(error?.localizedDescription, nil)
            }
        })
    }
    
}
