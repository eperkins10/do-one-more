//
//  MaxTableTableViewController.swift
//  DoOneMore
//
//  Created by Ethan Perkins on 11/19/21.
//

import UIKit

class MaxTableViewController: UITableViewController {

    var reps: String?
    var weight: String?
    
    var max: Max?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentAlert()
        WeightController.shared.loadFromPersistenceStorage()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func presentAlert() {
        guard let weight = weight,
              let reps = reps else { return }
        
        presentMaxAlert(weight: Int(weight)!, reps: Int(reps)!)
    }
    
    func presentMaxAlert(weight: Int, reps: Int) {
        let alert = UIAlertController(title: "New Max", message: "what exercise did you max on?", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter exercise"
            textField.autocorrectionType = .yes
            textField.autocapitalizationType = .sentences
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let addMaxAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            WeightController.shared.createMaxWith(reps: reps, weight: weight, exercise: text) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("unable to save max")
                }
            }
        }
        
        
        alert.addAction(cancelAction)
        alert.addAction(addMaxAction)
        
        self.present(alert, animated: true)
        
    }
    
    func setupViews() {
        self.view.backgroundColor = .systemGray
    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return WeightController.shared.maxs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "maxCell", for: indexPath) as? MaxTableViewCell else { return UITableViewCell() }

        let max = WeightController.shared.maxs[indexPath.row]
        
        cell.max = max

        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let maxToDelete = WeightController.shared.maxs[indexPath.row]
//            guard let index = WeightController.shared.maxs.firstIndex(of: maxToDelete) else { return }
            
            WeightController.shared.delete(maxToDelete)
            DispatchQueue.main.async {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    




    


}
