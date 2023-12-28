//
//  ItemsViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 27.12.2023.
//

import UIKit

class ItemsViewController: UIViewController {
    
    private let itemService: ItemService
    
    private lazy var addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(itemService: ItemService) {
        self.itemService = itemService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        layout()
    }
    
    @objc private func addBarButtonAction() {
        itemService.addItem(quote: "Загрузить")
        tableView.reloadData()
    }
    
    private func layout() {
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



extension ItemsViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemService.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let itemModel = itemService.items[indexPath.row]
        content.text = itemModel.quote
        content.secondaryText = itemModel.dateCreated.formatted()
        cell.contentConfiguration = content
        
        return cell
    }
}

extension ItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemService.deleteToDoItem(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

   
