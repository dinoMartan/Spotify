//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Dino Martan on 18/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import WebKit

class WelcomeViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - Actions -

extension WelcomeViewController {
    
    @IBAction func didPressSignInButton(_ sender: Any) {
        let authenticationViewController = UIViewController.MyViewControllers.authViewController
        authenticationViewController.authenticationDeleagete = self
        present(authenticationViewController, animated: true, completion: nil)
    }
    
}

//MARK: - Delegate -

extension WelcomeViewController: AuthenticationDelegate {
    
    func didCompeteAuthentication(with result: MyResult) {
        switch result {
            case .success:
                DispatchQueue.main.async { self.handleSignIn() }
            case .failure:
                let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntCompleteAPICall, button: .shame)
                present(alert, animated: true, completion: nil)
        }
    }
    
    private func handleSignIn() {
        let tabBarController = UIViewController.MyViewControllers.mainViewController
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
    
}
