//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import WebKit

class WelcomeViewController: UIViewController, WKNavigationDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func didPressSignInButton(_ sender: Any) {
        let authenticationViewController = UIViewController.MyViewControllers.authViewController
        
        authenticationViewController.completionHandler = { [unowned self] success in
            DispatchQueue.main.async {
                handleSignIn(success: success)
            }
        }
        
        //let authNavigationController = UINavigationController(rootViewController: authenticationViewController)
        //let viewControllers = [authenticationViewController]
        //navigationController?.setViewControllers(viewControllers, animated: true)
        //navigationController?.pushViewController(authenticationViewController, animated: true)
        
        present(authenticationViewController, animated: true, completion: nil)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = Alerter.getAlert(myTitle: ConstantsAlerts.AlertTitles.ops, myMessage: ConstantsAlerts.AlertMessages.didntSignIn, myButtonText: ConstantsAlerts.AlertButtonText.shame)
            present(alert, animated: true, completion: nil)
            return
        }
    
        let tabBarController = UIViewController.MyViewControllers.mainViewController
        
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
    
    
}
