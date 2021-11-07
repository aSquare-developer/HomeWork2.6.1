//
//  MainViewController.swift
//  HomeWork2.6.1
//
//  Created by Artur Anissimov on 05.11.2021.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewBackgroundColor(color: UIColor)
}

class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    var viewColor: UIColor!

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        viewColor = view.backgroundColor
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsViewController = segue.destination as? SettingsViewController else { return }
        settingsViewController.viewBackgroundColor = viewColor
        settingsViewController.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = viewColor
    }
}

// MARK: - SettingsViewControllerDelegate
extension MainViewController: SettingsViewControllerDelegate {
    func setNewBackgroundColor(color: UIColor) {
        viewColor = color
    }
}
