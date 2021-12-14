//
//  HomeViewController.swift
//  DoOneMore
//
//  Created by Ethan Perkins on 11/19/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var inputWeightTextField: UITextField!
    @IBOutlet weak var inputRepsTextField: UITextField!
    @IBOutlet weak var maxResultLabel: UILabel!
    @IBOutlet weak var calculateMaxButton: UIButton!
    @IBOutlet weak var saveMaxButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        WeightController.shared.loadFromPersistenceStorage()
    }

   
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    
    @IBAction func calculateMaxButtonTapped(_ sender: Any) {
        //FORMULA:  weight / 1.0278 - 0.0278 * reps
        calculateMax()
        self.view.endEditing(true)
    }
    
    @IBAction func resetFieldsButtonTapped(_ sender: Any) {
        maxResultLabel.text = ""
        inputWeightTextField.text = ""
        inputRepsTextField.text = ""
        
    }
    
    
    
    @IBAction func saveMaxButtonPressed(_ sender: Any) {
        maxResultLabel.text = ""
        inputWeightTextField.text = ""
        inputRepsTextField.text = ""
        
        guard let reps = inputRepsTextField.text, !reps.isEmpty,
              let weight = inputWeightTextField.text, !weight.isEmpty else { return }
        
        
    }
    
    func calculateMax() {
        let weightDouble = Double(inputWeightTextField.text!) ?? 0
        let repsDouble = Double(inputRepsTextField.text!) ?? 0
        
        let maxWeight = weightDouble / (1.0278 - 0.0278 * repsDouble)
        
        let roundedMaxWeight = Int(maxWeight)
        
        maxResultLabel.text = "Your 1RM: \(roundedMaxWeight) Pounds"
        
    }
    
    func setupViews() {
        self.view.backgroundColor = .systemGray
        maxResultLabel.layer.cornerRadius = 15.0
        maxResultLabel.layer.borderColor = UIColor.black.cgColor
        maxResultLabel.layer.borderWidth = 3.0
        calculateMaxButton.layer.borderColor = UIColor.black.cgColor
        calculateMaxButton.layer.borderWidth = 3.0
        calculateMaxButton.layer.cornerRadius = 10.0
        calculateMaxButton.frame.size.width = calculateMaxButton.intrinsicContentSize.width + 30
        calculateMaxButton.frame.size.height = calculateMaxButton.intrinsicContentSize.height + 10
        saveMaxButton.layer.cornerRadius = 15.0
        saveMaxButton.layer.borderColor = UIColor.black.cgColor
        saveMaxButton.layer.borderWidth = 3.0
        inputWeightTextField.layer.cornerRadius = 5
        inputWeightTextField.layer.borderColor = UIColor.black.cgColor
        inputWeightTextField.layer.borderWidth = 3.0
        inputWeightTextField.backgroundColor = .systemGray
        inputRepsTextField.layer.cornerRadius = 5
        inputRepsTextField.layer.borderColor = UIColor.black.cgColor
        inputRepsTextField.layer.borderWidth = 3.0
        inputRepsTextField.backgroundColor = .systemGray
    }
    
    
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSaveMaxVC" {
            guard let reps = inputRepsTextField.text, !reps.isEmpty,
                  let weight = inputWeightTextField.text, !weight.isEmpty else { return }
            
            guard let destination = segue.destination as? MaxTableViewController else { return }
            destination.reps = reps
            destination.weight = weight
        }
    }
}

