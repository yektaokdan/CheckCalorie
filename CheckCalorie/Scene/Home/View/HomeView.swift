//
//  ViewController.swift
//  CheckCalorie
//
//  Created by trc vpn on 19.03.2024.
//

import UIKit

class HomeView: UIViewController, UITextFieldDelegate {
    
    var selectedType: String?
    @IBOutlet weak var maleButtonUI: UIButton!
    @IBOutlet weak var femaleButtonUI: UIButton!
    @IBOutlet weak var calculateButtonUI: UIButton!
    @IBOutlet weak var ageTxtField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        ageTxtField.delegate = self
        weightTextField.delegate = self
        lengthTextField.delegate = self
        
        // Sayısal girişi zorunlu kılın
        ageTxtField.keyboardType = .decimalPad
        weightTextField.keyboardType = .decimalPad
        lengthTextField.keyboardType = .decimalPad
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = "0123456789.,"
            let characterSet = CharacterSet(charactersIn: allowedCharacters).inverted
            return string.rangeOfCharacter(from: characterSet) == nil
        }
        

        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    @IBAction func maleButtonTapped(_ sender: Any) {
        selectedType = "Male"
        updateUI()
    }
    @IBAction func femaleButtonTapped(_ sender: Any) {
        selectedType = "Female"
        updateUI()
    }
    
    @IBAction func calculateButtonTapped(_ sender: Any) {
        guard let age = ageTxtField.text, !age.isEmpty, let ageDouble = Double(age),
              let weight = weightTextField.text, !weight.isEmpty, let weightDouble = Double(weight.replacingOccurrences(of: ",", with: ".")),
              let length = lengthTextField.text, !length.isEmpty, let lengthDouble = Double(length.replacingOccurrences(of: ",", with: ".")) else {
            showAlert(message: "Please enter your age, weight and height information correctly.")
            ageTxtField.text = ""
            weightTextField.text = ""
            lengthTextField.text = ""
            return
        }
        if selectedType == "Male" {
            let maleResult = (10 * weightDouble) + (6.25 * lengthDouble) - (5 * ageDouble) + 5
            resultLabel.text = "The max calorie: \(maleResult)"
            resultLabel.isHidden = false
            
            
        } else if selectedType == "Female" {
            let femaleResult = (10 * weightDouble) + (6.25 * lengthDouble) - (5 * ageDouble) - 161
            resultLabel.text = "The max calorie: \(femaleResult)"
            resultLabel.isHidden = false
        }
        else{
            showAlert(message: "Please specify your gender.")
        }
    }
    func convertToMeters(input: String) -> Double? {
        let inputValue = input.replacingOccurrences(of: ",", with: ".")
        guard let number = Double(inputValue) else { return nil }
        
        if number < 3 { // Kullanıcı muhtemelen metre cinsinden giriş yaptı (örn. 1,78)
            return number
        } else { // Kullanıcı santimetre cinsinden giriş yaptı (örn. 178)
            return number / 100.0
        }
    }

    func updateUI(){
        maleButtonUI.layer.cornerRadius = 5
        maleButtonUI.layer.masksToBounds = true
        femaleButtonUI.layer.cornerRadius = 5
        femaleButtonUI.layer.masksToBounds = true
        calculateButtonUI.layer.cornerRadius = 20
        calculateButtonUI.layer.masksToBounds = true
        if selectedType == "Male"{
            maleButtonUI.backgroundColor = .black
            femaleButtonUI.backgroundColor = .systemTeal
        }
        else if(selectedType == "Female"){
            femaleButtonUI.backgroundColor = .black
            maleButtonUI.backgroundColor = .systemTeal
        }
        else{
            maleButtonUI.backgroundColor = .systemTeal
            femaleButtonUI.backgroundColor = .systemTeal
        }
    }
    
}

