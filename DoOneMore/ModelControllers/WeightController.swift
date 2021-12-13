//
//  WeightController.swift
//  DoOneMore
//
//  Created by Ethan Perkins on 11/19/21.
//

import Foundation

class WeightController {
    
    static let shared = WeightController()
    
    var maxs: [Max] = []
    
    //CRUD
    
    func createMaxWith(reps: Int, weight: Int, completion: @escaping (Bool) -> Void) {
        let newMax = Max(reps: reps, weight: weight)
        maxs.append(newMax)
        loadFromPersistenceStorage()
    }
    
    func delete(max: Max) {
        guard let index = maxs.firstIndex(of: max) else { return }
        maxs.remove(at: index)
        loadFromPersistenceStorage()
    }
    
    
    
    //Persistence
    
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    
    func saveToPersistenceStorage() {
        do {
            let data = try JSONEncoder().encode(maxs)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
            print("we had an error saving to our persistence store")
        }
    }
    
    
    func loadFromPersistenceStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            maxs = try JSONDecoder().decode([Max].self, from: data)
        } catch {
            print("we had an error loading our data from our persistence store")
            print(error)
            print(error.localizedDescription)
        }
    }
}
