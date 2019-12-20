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
    var login: LoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFacebookLogin(_ sender: Any) {
        login = FacebookLogin()
          login?.requestLogin() { result in
              if let user = try? result.get(), let name = user.name {
                  self.userDataLabel.text = "Logged with mail: " + name
              }
          }
    }
    
    @IBAction func onGoogleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
        print("Requested login with google")
    }
    
    @IBAction func onEmailLogin(_ sender: Any) {
        print("Requested login with email")
        // Call https://jsonplaceholder.typicode.com/users
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                if let firstUser = jsonObj.first as? [String: Any]{
                    DispatchQueue.main.async {
                         self.userDataLabel.text = "Logged with mail: " + (firstUser["name"] as! String)
                    }
                }

            }
        }

        task.resume()

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            userDataLabel.text = "Logged with Google: " + user.profile.name
        }
    }
    
}



