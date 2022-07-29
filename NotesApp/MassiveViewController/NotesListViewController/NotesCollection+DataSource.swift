//
//  NotesCollection+DataSource.swift
//  NotesApp
//
//  Created by Андрей Сорокин
//
import UIKit

extension NotesCollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Notes.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Notes.ID>
    
    // MARK: - Spanps update
    
    func updateSpapshot(upadate id: [Notes.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(filterNotes.map { $0.id })
        if !id.isEmpty {
            snapshot.reloadItems(id)
        }
        dataSource.apply(snapshot)
    }
    
    // MARK: - Registration cell
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Notes.ID) {
        let model = modelFeth(for: id)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = model.notes
        contentConfiguration.textProperties.numberOfLines = 2
        guard let modelDate = model.dueDate else { return }
        contentConfiguration.secondaryText = modelDate.dateToString
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
    }
    
    // MARK: - Feth, update, add and deleted Notes
    
    func modelFeth(for id: Notes.ID) -> Notes {
        let index = model.indexOfNotes(with: id)
        return model[index]
    }
    
    func updateModel(_ notes: Notes, with id: Notes.ID) {
        let index = model.indexOfNotes(with: id)
        model[index] = notes
    }

    func addNotes(_ data: Notes) {
       guard data.notes != nil else { return }
            data.id = UUID()
            data.dueDate = Date.now
            model.append(data)
    }
    
    func deletedNotes(with id: Notes.ID) {
        deletedNotes(id: id)
    }   
}


