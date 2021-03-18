//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func didPressSignInButton(_ sender: Any) {
        let autheticationViewController = UIStoryboard(name: "Authentication", bundle: nil).instantiateViewController(identifier: "authentication")
        self.present(autheticationViewController, animated: true)
        
    }
    
}
