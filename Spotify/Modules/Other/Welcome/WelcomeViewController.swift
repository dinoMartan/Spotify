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
        guard let authenticationViewController = UIStoryboard.Storyboard.authentication.viewController as? AuthenticationViewController else { return }
        authenticationViewController.authenticationDeleagete = self
        present(authenticationViewController, animated: true, completion: nil)
    }
    
}

//MARK: - Delegate -

extension WelcomeViewController: AuthenticationDelegate {
    
    func didCompleteAuthentication(with result: MyResult) {
        switch result {
            case .success:
                DispatchQueue.main.async { self.handleSignIn() }
            case .failure:
                let alert = Alerter.getAlert(myTitle: .ops, myMessage: .didntCompleteAPICall, button: .ok)
                present(alert, animated: true, completion: nil)
        }
    }
    
}

//MARK: - Private extensions -

private extension WelcomeViewController {
    
    private func handleSignIn() {
        let tabBarController = UIStoryboard.Storyboard.main.viewController
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
    
}
