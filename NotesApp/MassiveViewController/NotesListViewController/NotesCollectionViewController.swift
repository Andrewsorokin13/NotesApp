
//  NotesApp
//
//  Created by Андрей Сорокин
//
import UIKit
import CoreData

class NotesCollectionViewController: UICollectionViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var model: [Notes] = []
    var dataSource: DataSource!
    var filterNotes: [Notes] {
        return model.sorted { $0.dueDate! > $1.dueDate! }
    }
    
    // MARK: - live Style View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, id: Notes.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: id)
        }
        
        navigationItem.title = NSLocalizedString("Заметки", comment: "Заоловок заметок")
        let addNavButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didPressedAddButton(_:)))
        navigationItem.rightBarButtonItem = addNavButton
        
        loaDate()
        updateSpapshot()
        collectionView.dataSource = dataSource
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        savetyContex()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = filterNotes[indexPath.item].id
        showDetail(for: id)
        return true
    }
    
    func showDetail(for id: Notes.ID) {
        let model = modelFeth(for: id)
        let NewVC = DetailNotesViewController(model: model) { [weak self] model in
            self?.updateModel(model, with:model.id )
            self?.updateSpapshot(upadate: [model.id])
        }
        NewVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(NewVC, animated: true)
    }
    
    private func swipeToDeletedActions(for index: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let index = index,
              let id = dataSource.itemIdentifier(for: index) else { return nil }
        let actionTitle = NSLocalizedString("Удалить", comment: "")
        let action = UIContextualAction(style: .destructive, title: actionTitle) { [weak self] _, _, completion in
            self?.deletedNotes(with: id)
            self?.updateSpapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // MARK: - Collection Layout
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = swipeToDeletedActions
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
