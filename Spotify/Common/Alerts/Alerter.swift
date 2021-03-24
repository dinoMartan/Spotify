//
//  Alerter.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class Alerter {
    
    static func getAlert(myTitle: ConstantsAlerts.Titles, myMessage: ConstantsAlerts.Messages, button: ConstantsAlerts.Button) -> UIAlertController {
        let alert = UIAlertController(title: myTitle.rawValue, message: myMessage.rawValue, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: button.rawValue, style: .default, handler: nil))
        return alert
    }
    
}
