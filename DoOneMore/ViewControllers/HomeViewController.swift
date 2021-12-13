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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func calculateMaxButtonTapped(_ sender: Any) {
        //FORMULA:  weight / 1.0278 - 0.0278 * reps
        calculateMax()
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
