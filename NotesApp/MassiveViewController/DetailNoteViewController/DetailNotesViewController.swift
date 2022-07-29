//
//  DetailNotesViewController.swift
//  NotesApp
//
//  Created by Андрей Сорокин

import UIKit
import CoreData

class DetailNotesViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    private  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    private var dataSource: DataSource!
    
    var model: Notes {
        didSet {
            onChange(model)
        }
    }
    var temporaryModel: Notes
    var onChange: (Notes) -> Void
    var isAddingNewNotes = false
    
    // MARK: - Init
    
    init(model: Notes, onChange: @escaping (Notes)-> Void){
        self.model = model
        self.temporaryModel = model
        self.onChange = onChange
        var listCondiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listCondiguration.showsSeparators = false
        listCondiguration.headerMode = .firstItemInSection
        let listLayout = UICollectionViewCompositionalLayout.list(using: listCondiguration)
        super.init(collectionViewLayout: listLayout)
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - live Style View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandlet)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, id: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: id)
        }
        navigationItem.rightBarButtonItem = editButtonItem

        
        updateSnapshotForView()
        
        
        let tapToView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_ :)))
        tapToView.numberOfTapsRequired = 2
        self.collectionView.addGestureRecognizer(tapToView)
    }
    
    @objc func tap (_ : UIPanGestureRecognizer) {
        setEditing(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if model != temporaryModel {
            saveContex()
        }
    }
    
    // MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: - Set Editing
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
           prepareForEditing()
        } else {
            if !isAddingNewNotes {
                prepareForViewing()
            } else {
               onChange(temporaryModel)
            }
        }
    }
    
    // MARK: - Registration cell
    
    func cellRegistrationHandlet(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header): cell.contentConfiguration = headerConfiguration(for: cell, with: model.dueDate?.dateToString ?? "")
        case (.view, _): cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.notes, .editText(let notes)): cell.contentConfiguration = textViewConfig(for: cell, with: notes)
        default:  fatalError("ONe")
        }
    }
    
    // MARK: - Prepare View
    
    private func prepareForViewing() {
        navigationItem.leftBarButtonItem = nil
        if temporaryModel != model {
            model = temporaryModel
        }
        updateSnapshotForView()
    }
    
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelEdit))
        updateSnapshotForEditing()
    }
    
    // MARK: - Update View
    
    private func updateSnapshotForView() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([.header(model.dueDate?.dateToString ?? ""), .viewNotes], toSection: .view)
        dataSource.apply(snapshot)
    }
    
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.notes])
        snapshot.appendItems([.header(Section.notes.name), .editText(model.notes)], toSection: .notes)
        dataSource.apply(snapshot)
    }
    
    // MARK: - Section
    
    private func section(for indexPath: IndexPath) -> Section {
          let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
          guard let section = Section(rawValue: sectionNumber) else {
              fatalError("Unable to find matching section")
          }
        return section
      }
    
    // MARK: - Save to Core data
    
    private func saveContex() {
        do {
            guard  model != temporaryModel else { return  }
            print("jh")
            try context.save()
        } catch {
            print("asdada\(error)")
        }
    }
}


