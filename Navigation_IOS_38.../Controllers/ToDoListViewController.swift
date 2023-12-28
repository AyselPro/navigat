//
//  ToDoListViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 27.12.2023.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    private let toDoService: ToDoService
    
    private lazy var addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonAction))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(toDoService: ToDoService) {
        self.toDoService = toDoService
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
        toDoService.dowlandToDoItem(quote: "Загрузить")
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



extension ToDoListViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoService.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let toDoModel = toDoService.toDoList[indexPath.row]
        content.text = toDoModel.quote
        content.secondaryText = toDoModel.dateCreated.formatted()
        cell.contentConfiguration = content
        
        return cell
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoService.deleteToDoItem(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let toDoModel = toDoService.toDoList[indexPath.row]
        let itemService = ItemService(toDoModel: toDoModel)
        let itemsViewController = ItemsViewController(itemService: itemService)
        navigationController?.pushViewController(itemsViewController, animated: true)
    }
    
}
