//
//  ViewController.swift
//  LoginRefactor
//
//  Created by Maola Ma on 11/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin

class ViewController: UIViewController, GIDSignInDelegate {
    
    
    @IBOutlet weak var userDataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFacebookLogin(_ sender: Any) {
        print("Requested login with facebook")
        guard AccessToken.current == nil else {
            self.getFbUserInfo()
            return
        }
        
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: [ "public_profile" ]) {[weak self] (loginResult) in
            guard let self = self else { return }
            switch loginResult {
            case .failed(let error):
                //        del.didFailedWithError(error.localizedDescription)
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                if grantedPermissions.contains("email") && grantedPermissions.contains("public_profile") {
                    self.getFbUserInfo()
                }
            }
        }
    }
    
    @IBAction func onGoogleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        print("Requested login with google")
    }
    
    @IBAction func onEmailLogin(_ sender: Any) {
        print("Requested login with email")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            userDataLabel.text = user.profile.name
        }
    }
    
    
    private func getFbUserInfo() {
        guard AccessToken.current != nil else {
            return
        }
        
        let myGraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, birthday, age_range, picture.width(400), gender"], tokenString: AccessToken.current?.tokenString, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
        
        myGraphRequest.start(completionHandler: { (connection, result, error) in
            if let res = result {
                let responseDict = res as! [String:Any]
                
                let fullName = responseDict["name"] as! String
                let firstName = responseDict["first_name"] as! String
                let lastName = responseDict["last_name"] as! String
                let email = responseDict["email"] as! String
                let idFb = responseDict["id"] as! String
                let pictureDict = responseDict["picture"] as! [String:Any]
                let imageDict = pictureDict["data"] as! [String:Any]
                let imageUrl = imageDict["url"] as! String
                
                print("user id: \(idFb), firstName: \(firstName), fullname: \(fullName), lastname: \(lastName), picture: \(imageUrl), email: \(email)")
                self.userDataLabel.text = fullName
                
                
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
}

