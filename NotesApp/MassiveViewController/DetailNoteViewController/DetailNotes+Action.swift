//
//  DetailNotes+Action.swift
//  NotesApp
//
//  Created by Андрей Сорокин
//

import Foundation

extension DetailNotesViewController {
    
    // MARK: - Button cancel edit
    
    @objc func didCancelEdit() {
        temporaryModel = model
        setEditing(false, animated: true)
    }
    
    
}
