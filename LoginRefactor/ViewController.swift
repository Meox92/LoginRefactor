//
//  ViewController.swift
//  LoginRefactor
//
//  Created by Maola Ma on 11/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//

import UIKit
import GoogleSignIn


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
    
}

