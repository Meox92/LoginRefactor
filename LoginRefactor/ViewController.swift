//
//  ViewController.swift
//  LoginRefactor
//
//  Created by Maola Ma on 11/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userDataLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFacebookLogin(_ sender: Any) {
        print("Requested login with facebook")
    }
    
    @IBAction func onGoogleLogin(_ sender: Any) {
        print("Requested login with facebook")
    }
    
    @IBAction func onEmailLogin(_ sender: Any) {
        print("Requested login with facebook")
    }
    
}

