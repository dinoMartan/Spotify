//
//  UIStoryboardExtensions.swift
//  Spotify
//
//  Created by Dino Martan on 21/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    struct MyBoards {
        static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        static let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        static let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        static let libraryStoryboard = UIStoryboard(name: "Library", bundle: nil)
        
        static let authStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        static let welcomeStoryboard = UIStoryboard(name: "Welcome", bundle: nil)
        static let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
    }
    
}
