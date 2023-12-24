//
//  ListViewController.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 23.12.2023.
//

import UIKit

final class ListViewController: UIViewController {
    
    private let fileManagerService: FileManagerService
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var addDirectoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var addFileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Documents"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        nameLabel.backgroundColor = .lightGray
        nameLabel.layer.masksToBounds = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
  
    private lazy var  createLabel: UILabel = {
        let createLabel = UILabel()
        createLabel.text = "Create new folder"
        createLabel.font = UIFont.boldSystemFont(ofSize: 20)
        createLabel.textColor = .black
        createLabel.backgroundColor = .white
        createLabel.textAlignment = .center
        createLabel.layer.masksToBounds = true
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        return createLabel
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 30)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Folder name"
        textField.textColor = .lightGray
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.white.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(fileManagerService: FileManagerService) {
        self.fileManagerService = fileManagerService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        layout()
    }
    
    @objc private func addButtonAction(button: UIButton) {
        switch button {
        case addDirectoryButton:
            fileManagerService.addDirectory(name: "New Folder")
            tableView.reloadData()
            
        case addFileButton:
            fileManagerService.createFile(name: "On More Folder", content: "")
            tableView.reloadData()
            
        default:
            break
        }
    }
    
    private func layout() {
        view.addSubview(addDirectoryButton)
        view.addSubview(addFileButton)
        view.addSubview(tableView)
        view.addSubview(nameLabel)
        view.addSubview(textField)
        view.addSubview(createLabel)
        
        NSLayoutConstraint.activate([
            addDirectoryButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            addDirectoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addDirectoryButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            addDirectoryButton.heightAnchor.constraint(equalToConstant: 50),
            
            addFileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            addFileButton.leadingAnchor.constraint(equalTo: addDirectoryButton.trailingAnchor, constant: 16),
            addFileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addFileButton.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: addDirectoryButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            createLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 160),
            createLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
            textField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 180),
            textField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 34),
        ])
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fileManagerService.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = fileManagerService.items[indexPath.row]
        content.secondaryText = fileManagerService.isDirectoryAtIndex(indexPath.row) ? "Папка" : "Файл"
        cell.contentConfiguration = content
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fileManagerService.deleteItem(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = fileManagerService.getPath(at: indexPath.row)
        let fileManagerService = FileManagerService(pathForFolder: path)
        let nextListViewController = ListViewController(fileManagerService: fileManagerService)
        navigationController?.pushViewController(nextListViewController, animated: true)
    }
}
