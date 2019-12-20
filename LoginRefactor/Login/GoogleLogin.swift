//
//  GoogleLogin.swift
//  LoginRefactor
//
//  Created by Maola Ma on 20/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//
import Foundation
import GoogleSignIn

class GoogleLogin: NSObject, GIDSignInDelegate, LoginProtocol {
    var completion: loginCompletion!
    var gLoginInstance: GIDSignIn = GIDSignIn.sharedInstance()
    
    deinit {
        print("Deallocing \(self)")
    }
    
    override init() {
        super.init()
        gLoginInstance.presentingViewController = UIApplication.shared.keyWindow?.rootViewController
        gLoginInstance.delegate = self
    }
    
    func requestLogin(completion: @escaping loginCompletion) {
        gLoginInstance.signIn()
        self.completion = completion
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            completion(.failure(error))
        } else {
            let user = User(name: user.profile.name )
            completion(.success(user))
        }
    }
    
}
