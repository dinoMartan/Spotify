//
//  SettingsCell.swift
//  Spotify
//
//  Created by Dino Martan on 24/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    //MARK: - IBOutlets

    @IBOutlet private weak var title: UILabel!
    
    func setSetting(setting: Setting) {
        title.text = setting.title
    }
    
}
