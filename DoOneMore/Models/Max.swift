//
//  File.swift
//  DoOneMore
//
//  Created by Ethan Perkins on 11/19/21.
//

import Foundation

class Max: Codable {
    let reps: Int
    let weight: Int
    var exercise: String
    
    
    
    init(reps: Int, weight: Int, exercise: String) {
        self.reps = reps
        self.weight = weight
        self.exercise = exercise
    }
}

extension Max: Equatable {
    static func == (lhs: Max, rhs: Max) -> Bool {
        lhs.reps == rhs.reps && lhs.weight == rhs.weight
    }
    
    
}
