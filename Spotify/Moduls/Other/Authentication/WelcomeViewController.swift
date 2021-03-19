//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

    @IBAction func didPressSignInButton(_ sender: Any) {
        // to do - log user in
        let fieldsOk = checkFields()
        
    }
    
    
    private func checkFields() -> Bool{
        if(username.hasText && password.hasText) {
            return true
            
        }
        else{
            let alert = Alerter.getAlert(myTitle: "Oops!", myMessage: "Username and/or password are not inserted!", myButtonText: "OK")
            self.present(alert, animated: true, completion: nil)
            return false
        }
    }
    
}
