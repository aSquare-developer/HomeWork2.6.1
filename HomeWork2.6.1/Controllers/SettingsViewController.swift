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
    var viewBackgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: - Private Properties
    private var red: CGFloat = 0
    private var green: CGFloat = 0
    private var blue: CGFloat = 0
    private var alpha: CGFloat = 0
 
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        
        colorView.backgroundColor = viewBackgroundColor

        viewBackgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        rgbSliderSettings()
        labelAndTextFieldSettings()
    }

    // MARK: - IB Actions
    @IBAction func rgbSliderChanged() {
        labelAndTextFieldSettings()
        changeColorInView()
    }
    
    @IBAction func doneButtonTapped() {
        view.endEditing(true)
        viewBackgroundColor = colorView.backgroundColor
        delegate.setNewBackgroundColor(color: viewBackgroundColor)
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func changeColorInView() {
        colorView.backgroundColor = UIColor(displayP3Red: CGFloat(redColorSlider.value),
                                            green: CGFloat(greenColorSlider.value),
                                            blue: CGFloat(blueColorSlider.value),
                                            alpha: 1)
    }
    
    private func labelAndTextFieldSettings() {
        redTextField.text = String(format: "%.2f", redColorSlider.value)
        greenTextField.text = String(format: "%.2f", greenColorSlider.value)
        blueTextField.text = String(format: "%.2f", blueColorSlider.value)
        
        redColorLabel.text = String(format: "%.2f", redColorSlider.value)
        greenColorLabel.text = String(format: "%.2f", greenColorSlider.value)
        blueColorLabel.text = String(format: "%.2f", blueColorSlider.value)
        
    }
    
    private func rgbSliderSettings() {
        redColorSlider.value = Float(red)
        greenColorSlider.value = Float(green)
        blueColorSlider.value = Float(blue)
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
        guard let number = Float(value) else { return }
        
        if number > 1.0 {
            showAlert(title: "Invalid number", message: "Number must be between from 0 to 1", textField: textField)
        } else if textField == redTextField {
            redColorSlider.value = number
            redColorLabel.text = String(number)
            changeColorInView()
        } else if textField == greenTextField {
            greenColorSlider.value = number
            greenColorLabel.text = String(number)
            changeColorInView()
        } else if textField == blueTextField {
            blueColorSlider.value = number
            blueColorLabel.text = String(number)
            changeColorInView()
        }
        
    }
}
