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
    
    @IBOutlet private weak var tableView: UITableView!
    
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
        title = "Settings"
    }

}

//MARK: - Public extensions -

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = sections[indexPath.section].settings[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsConstants.Keys.settingsCell) as? SettingsCell else {
            // to do - error handling
            fatalError()
        }
        cell.setSetting(setting: setting)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let setting = sections[indexPath.section].settings[indexPath.row]
        setting.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }
    
}

//MARK: - Private extensions -

private extension SettingsViewController {
    
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
    
}
