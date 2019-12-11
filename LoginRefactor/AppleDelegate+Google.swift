//
//  AppleDelegate+Google.swift
//  LoginRefactor
//
//  Created by Maola Ma on 11/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//

import Foundation
import GoogleSignIn


extension AppDelegate {
  
  func configureGGLContext() {
    GIDSignIn.sharedInstance().clientID = GOOGLE_API_KEY
  }
  
  func googleCanOpenURL(_ app: UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    return GIDSignIn.sharedInstance()!.handle(url)
  }
}
