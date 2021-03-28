//
//  AuthenticationViewController.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import WebKit

enum MyResult {
    
    case success
    case failure(error: Error?)
    
}

protocol AuthenticationDelegate: AnyObject {
    
    func didCompleteAuthentication(with result: MyResult)
    
}

class AuthenticationViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var wkWebView: WKWebView!
    @IBOutlet private weak var activityIndicatior: UIActivityIndicatorView!
    
    //MARK: - Publlic properties
    
    weak var authenticationDeleagete: AuthenticationDelegate?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        activityIndicatorSetup()
        webViewSetup()
    }
    
    func webViewSetup() {
        guard let url = AuthManager.shared.signInURL else { return }
        wkWebView.isHidden = true
        wkWebView.configuration.preferences.javaScriptEnabled = true
        wkWebView.navigationDelegate = self
        wkWebView.load(URLRequest(url: url))
    }
    
    func activityIndicatorSetup() {
        activityIndicatior.isHidden = false
    }
    
}

//MARK: - extensions -

extension AuthenticationViewController {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        wkWebView.isHidden = false
        activityIndicatior.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
 
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == AuthenticationConstants.Keys.code } )?.value
        else { return }
        
        webView.isHidden = true
        AuthManager.shared.exchangeCodeForToken(code: code) { [unowned self] success in
            DispatchQueue.main.async {
                authenticationDeleagete?.didCompleteAuthentication(with: .success)
                dismiss(animated: true, completion: nil)
            }
        } failure: { [unowned self] error in
            authenticationDeleagete?.didCompleteAuthentication(with: .failure(error: error))
            dismiss(animated: true, completion: nil)
        }
    }
    
}
