//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Dino Martan on 24/03/2021.
//  Copyright © 2021 Dino Martan. All rights reserved.
//

import UIKit

class SettingsViewController: DMViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - private properties
    
    private var sections: [Section] = []
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        setupSettings()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSettings() {
        let profileOption = Setting(title: "View your profile", handler: { [unowned self] in
            DispatchQueue.main.async { viewProfile() }
        })
        sections.append(Section(title: "Profile", settings: [profileOption]))
        
        let signOutOption = Setting(title: "Sign out", handler: { [unowned self] in
            DispatchQueue.main.async { signOut() }
        })
        sections.append(Section(title: "Account", settings: [signOutOption]))
    }
    
    private func viewProfile() {
        // TO DO: create profile storyboard and display it
        print("TO DO: create profile storyboard and display it")
    }
    
    private func signOut() {
        // TO DO: Sign out
        print("Sign out")
    }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = sections[indexPath.section].settings[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! SettingsCell
        cell.title.text = setting.title
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Call cell handler
        let setting = sections[indexPath.section].settings[indexPath.row]
        setting.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
    
}
