//
//  MainViewController.swift
//  HomeWork2.6.1
//
//  Created by Artur Anissimov on 05.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewBackgroundColor(color: UIColor?)
}

class MainViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsViewController = segue.destination as? SettingsViewController else { return }
        settingsViewController.viewColor = view.backgroundColor
        settingsViewController.delegate = self
    }
    
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setNewBackgroundColor(color: UIColor?) {
        view.backgroundColor = color
    }
}
