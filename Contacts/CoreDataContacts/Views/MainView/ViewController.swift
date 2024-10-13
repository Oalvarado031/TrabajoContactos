//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Macbook on 28/9/24.
//

import UIKit

enum Section {
    case main
}

class ViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Section, ContactModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ContactModel>

    @IBOutlet weak var tableView: UITableView!
    
    private var contacts = [ContactModel]()
    
    let controller = MainController()
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell
            
            cell?.nameLabel.text = itemIdentifier.name
            cell?.phoneLabel.text = String(itemIdentifier.number)
            cell?.addressLabel.text = itemIdentifier.address
            
            
            return cell
        }
        
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Contacts"
        
        tableView.delegate = self
        
        buttonConfiguration()
        cellRegistration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func getData() {
        contacts = controller.getContacts()
        applySnapshot()
    }
    
    private func cellRegistration() {
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
    }
    
    private func buttonConfiguration() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addContact))
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(contacts)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    @objc func addContact() {
        let addContactVC = AddContactViewController(controller: controller)
        navigationController?.pushViewController(addContactVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            if let selectedModel = self.dataSource.itemIdentifier(for: indexPath) {
                self.controller.removeContact(contact: selectedModel)
                completion(true)
                self.getData()
            }
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}

