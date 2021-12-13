//
//  MaxTableViewCell.swift
//  DoOneMore
//
//  Created by Ethan Perkins on 12/10/21.
//

import UIKit

class MaxTableViewCell: UITableViewCell {

    @IBOutlet weak var liftNameLabel: UILabel!
    @IBOutlet weak var savedMaxLabel: UILabel!
    
    
    var max: Max? {
        didSet {
            updateViews()
        }
    }
    
    func calculateMax() -> String {
        let weightDouble = Double(max?.weight ?? 0)
        let repsDouble = Double(max?.reps ?? 0)
        
        let maxWeight = weightDouble / (1.0278 - 0.0278 * repsDouble)
        
        let roundedMaxWeight = Int(maxWeight)
        
        return "\(roundedMaxWeight) lbs"
        
    }
    
    func updateViews() {
        liftNameLabel.text = max?.exercise
        savedMaxLabel.text = calculateMax()
    }
}
