//
//  Model.swift
//  NotesApp
//  Created by Андрей Сорокин
//

import Foundation

extension Array where Element == Notes {
    func indexOfNotes(with id: Notes.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

