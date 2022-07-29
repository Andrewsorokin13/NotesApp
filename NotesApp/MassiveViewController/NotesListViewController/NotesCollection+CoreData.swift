//
//  NotesCollection+CoreData.swift
//  NotesApp
//
//  Created by Андрей Сорокин
//

import Foundation
import CoreData

extension NotesCollectionViewController {
    
    // MARK: - Load and deleted from CoreDate
    
    func loaDate() {
        let request: NSFetchRequest<Notes> = Notes.fetchRequest()
        do {
            model = try context.fetch(request)
        }catch {
            print("Error feth")
        }
    }
    
     func savetyContex() {
        do {
            try context.save()
        } catch {
            print("asdada\(error)")
        }
    }
    
    func deletedNotes(id: Notes.ID) {
        let index = model.indexOfNotes(with: id)
        do {
           context.delete(model[index])
           model.remove(at: index)
        }
    }
}
