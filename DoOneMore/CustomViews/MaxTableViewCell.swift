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
        didSet{
            
        }
    }
    
    func updateViews() {
        
    }
}
