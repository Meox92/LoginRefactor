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
    var login: LoginProtocol?
    let factory: LoginFactory = LoginFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onFacebookLogin(_ sender: Any) {
        login = factory.create(for: .Facebook)
        requestLogin(login, method: .Facebook)
    }
    
    @IBAction func onGoogleLogin(_ sender: Any) {
        login = factory.create(for: .Google)
        requestLogin(login, method: .Google)
    }
    
    @IBAction func onEmailLogin(_ sender: Any) {
        login = factory.create(for: .Email)
        requestLogin(login, method: .Email)
    }
    
    func requestLogin(_ login: LoginProtocol?, method: LoginChoice) {
        login?.requestLogin() { [weak self] result in
            guard let self = self else { return }
            
            if let user = try? result.get(), let name = user.name {
                DispatchQueue.main.async {
                    self.userDataLabel.text = "Logged with \(method.rawValue): " + name
                }
            } else {
                self.userDataLabel.text = "Error on login"
            }
        }
    }
    
}



