//
//  Alerter.swift
//  Spotify
//
//  Created by Dino Martan on 19/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

public class Alerter {
    
    static func getAlert(myTitle: String, myMessage: String, myButtonText: String) -> UIAlertController {
        let alert = UIAlertController(title: myTitle, message: myMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: myButtonText, style: .default, handler: nil))
        return alert
    }
}
