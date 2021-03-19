//
//  AuthenticationViewController.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit
import WebKit

class AuthenticationViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    public var completionHandler: ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        wkWebView.configuration.preferences.javaScriptEnabled = true
        
        
        wkWebView.navigationDelegate = self
        view.addSubview(wkWebView)

        guard let url = AuthManager.shared.signInURL else{
            return
        }
        
        print(url.absoluteString)
        wkWebView.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else{
            return
        }
        
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
        else{
            return
        }
        
        webView.isHidden = true
        //self.dismiss(animated: true, completion: nil)
        AuthManager.shared.exchangeCodeForToken(code: code){ [weak self] success in
            DispatchQueue.main.async {
                self?.completionHandler?(success)
                self?.navigationController?.popToRootViewController(animated: true)
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }


}
