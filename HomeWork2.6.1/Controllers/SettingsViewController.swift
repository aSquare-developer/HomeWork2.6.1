//
//  SettingsViewController.swift
//  HomeWork2.6.1
//
//  Created by Artur Anissimov on 05.11.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var blueColorSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    // MARK: - Public Properties
    var viewColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
 
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        
        colorView.backgroundColor = viewColor
        
        rgbSliderSettings()
        setValue(for: redColorLabel, greenColorLabel, blueColorLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }

    // MARK: - IB Actions
    @IBAction func rgbSliderChanged(_ sender: UISlider) {
        
        switch sender {
        case redColorSlider:
            setValue(for: redColorLabel)
            setValue(for: redTextField)
        case greenColorSlider:
            setValue(for: greenColorLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueColorLabel)
            setValue(for: blueTextField)
        }
        
        changeColorInView()
    }
    
    @IBAction func doneButtonTapped() {
        delegate.setNewBackgroundColor(color: colorView.backgroundColor)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func changeColorInView() {
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value),
                                            blue: CGFloat(blueColorSlider.value),
                                            alpha: 1)
    }
        
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorLabel: label.text = string(from: redColorSlider)
            case greenColorLabel: label.text = string(from: greenColorSlider)
            default: label.text = string(from: blueColorSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = string(from: redColorSlider)
            case greenTextField: textField.text = string(from: greenColorSlider)
            default: textField.text = string(from: blueColorSlider)
            }
        }
    }
    
    private func rgbSliderSettings() {
        let ciColor = CIColor(color: viewColor)
        
        redColorSlider.value = Float(ciColor.red)
        greenColorSlider.value = Float(ciColor.green)
        blueColorSlider.value = Float(ciColor.blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension SettingsViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let value = textField.text else { return }

        if let number = Float(value) {
            switch textField {
            case redTextField:
                redColorSlider.setValue(number, animated: true)
                setValue(for: redColorLabel)
            case greenTextField:
                greenColorSlider.setValue(number, animated: true)
                setValue(for: greenColorLabel)
            default:
                blueColorSlider.setValue(number, animated: true)
                setValue(for: blueColorLabel)
            }
            
            changeColorInView()
            return
        }
        
        showAlert(title: "Invalid number", message: "Number must be between from 0 to 1", textField: textField)
    }
}
