//
//  DetailNotes+Section.swift
//  NotesApp
//
//  Created by Андрей Сорокин
//

import Foundation

extension DetailNotesViewController {
    enum Section: Int, Hashable {
        case view
        case notes
        
        var name: String {
            switch self {
            case .view: return ""
            case .notes: return NSLocalizedString("Note", comment: "sa")
            }
        }
    }
}
