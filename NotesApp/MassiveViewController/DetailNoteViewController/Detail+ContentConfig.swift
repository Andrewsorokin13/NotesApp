//
//  Detail+ContentConfig.swift
//  NotesApp
//
//  Created by Андрей Сорокин
//

import UIKit

extension DetailNotesViewController {

    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = title
        contentConfiguration.textProperties.alignment = .center
        return contentConfiguration
    }

    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row) -> UIListContentConfiguration {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        return contentConfiguration
    } 
    
    func textViewConfig(for cell: UICollectionViewListCell, with notes: String?, isHidenButton: Bool = false) -> TextViewContentView.ContenConfiguration{
        var contentConfiguration = cell.textViewConfiguration()
        contentConfiguration.text = notes
        contentConfiguration.onChange = { [weak self] note in
            self?.temporaryModel.notes = note
        }
        return contentConfiguration
    }
    
    func text(for row: Row) -> String? {
        switch row {
        case .header: return model.dueDate?.dateToString
        case .viewNotes: return model.notes
        default : return nil
        }
    }
}
