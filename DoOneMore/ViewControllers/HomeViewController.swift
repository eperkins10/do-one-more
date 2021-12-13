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
        
        let weightDouble = Double(inputWeightTextField.text!) ?? 0
        let repsDouble = Double(inputRepsTextField.text!) ?? 0
        
        let maxWeight = weightDouble / (1.0278 - 0.0278 * repsDouble)
        
        let roundedMaxWeight = Int(maxWeight)
        
        maxResultLabel.text = "Your 1RM: \(roundedMaxWeight) Pounds"
    }
    

    @IBAction func saveMaxButtonPressed(_ sender: Any) {
        maxResultLabel.text = ""
        guard let reps = inputRepsTextField.text, !reps.isEmpty,
              let weight = inputWeightTextField.text, !weight.isEmpty else { return }
        
        
    }
    
    
    func presentMaxAlert(_ max: Max) {
        let alert = UIAlertController(title: "New Max", message: "what excersize did you max on?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter excersize"
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addMaxAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(addMaxAction)
        
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMaxViewVC" {
            let maxTableViewController = segue.destination as! MaxTableViewController
        }
    }
    

}
