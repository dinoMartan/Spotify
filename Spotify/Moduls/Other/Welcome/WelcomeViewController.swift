//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import WebKit

class WelcomeViewController: UIViewController, WKNavigationDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

    @IBAction func didPressSignInButton(_ sender: Any) {
        let authenticationStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        let authenticationViewController = authenticationStoryboard.instantiateViewController(identifier: "authentication") as AuthenticationViewController
        
        authenticationViewController.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        
        present(authenticationViewController, animated: true, completion: nil)
    }
    
    private func handleSignIn(success: Bool){
        // login or error
    }
    
    
}
