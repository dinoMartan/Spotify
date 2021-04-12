//
//  Alerter.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class Alerter {
    
    static func getAlert(myTitle: AlertsConstants.Titles, myMessage: AlertsConstants.Messages, button: AlertsConstants.Button) -> UIAlertController {
        let alert = UIAlertController(title: myTitle.rawValue, message: myMessage.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button.rawValue, style: .default, handler: nil))
        return alert
    }
    
    static func getAlert(myTitle: AlertsConstants.Titles, error: Error, button: AlertsConstants.Button) -> UIAlertController {
        let alert = UIAlertController(title: myTitle.rawValue, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button.rawValue, style: .default, handler: nil))
        return alert
    }
    
    static func getAlert(myTitle: String, error: String, button: String) -> UIAlertController {
        let alert = UIAlertController(title: myTitle, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: nil))
        return alert
    }
    
    static func getActionSheet(myTitle: String, message: AlertsConstants.Messages, button: AlertsConstants.Button) -> UIAlertController {
        let alert = UIAlertController(title: myTitle, message: message.rawValue, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: button.rawValue, style: .default, handler: nil))
        return alert
    }
    
}
