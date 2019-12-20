//
//  EmailLogin.swift
//  LoginRefactor
//
//  Created by Maola Ma on 20/12/2019.
//  Copyright © 2019 Maola. All rights reserved.
//

import Foundation

class EmailLogin:LoginProtocol {
    func requestLogin(completion: @escaping (Result<User, Error>) -> Void) {
        // Call https://jsonplaceholder.typicode.com/users
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                if let firstUser = jsonObj.first as? [String: Any], let name = firstUser["name"] as? String {
                    let user = User(name: name)
                    completion(.success(user))
                }
            }
        }
        task.resume()
    }
    
}
