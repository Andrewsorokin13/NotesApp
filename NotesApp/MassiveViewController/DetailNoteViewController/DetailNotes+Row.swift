//
//  DetailNotes+Row.swift
//  NotesApp
//
//  Created by Андрей Сорокин on 27/07/2022.
//

import UIKit

extension DetailNotesViewController {
    enum Row: Hashable {
        case header(String)
        case viewNotes
        case editText(String?)
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .viewNotes:
                return .subheadline
            default : return .headline
            }
        }
    }
}
