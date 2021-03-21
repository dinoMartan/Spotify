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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - Actions -

extension WelcomeViewController {
    
    @IBAction func didPressSignInButton(_ sender: Any) {
        let authenticationViewController = UIViewController.MyViewControllers.authViewController
        authenticationViewController.authDelegate = self
        
        //let authNavigationController = UINavigationController(rootViewController: authenticationViewController)
        //let viewControllers = [authenticationViewController]
        //navigationController?.setViewControllers(viewControllers, animated: true)
        //navigationController?.pushViewController(authenticationViewController, animated: true)
        
        present(authenticationViewController, animated: true, completion: nil)
    }
    
}

//MARK: - Delegate -

extension WelcomeViewController: AuthenticationDelegate {
    
    // if is logged in, show main screen
    func didCompleteAPICall() {
        DispatchQueue.main.async {
            let tabBarController = UIViewController.MyViewControllers.mainViewController
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true, completion: nil)
        }
    }
    
    func didNotCompleteAPICall() {
        let alert = Alerter.getAlert(myTitle: ConstantsAlerts.AlertTitles.ops, myMessage: ConstantsAlerts.AlertMessages.didntSignIn, myButtonText: ConstantsAlerts.AlertButtonText.shame)
        present(alert, animated: true, completion: nil)
    }
    
}
