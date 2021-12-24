//
//  ViewController.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/12/21.
//

import UIKit
import SnapKit

class RepositoriesViewController: UIViewController {
    
    var viewModel: RepositoriesListViewModelPortocol!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.tableHeaderView = UIView()
        tableView.regisger(cellClass: RepositoryTableViewCell.self)
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadList()
    }
    
    private func setup() {
        viewModel = RepositoriesListViewModel()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension RepositoriesViewController: RepositoriesListViewModelDelegate {
    func displayError(_ error: ListError) {
        DispatchQueue.main.async {
            self.presentMessage(message: error.localizedMessage)
        }
    }
    
    func didLoadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.cellId) as! RepositoryTableViewCell
        let repository = getItem(indexPath: indexPath)
        cell.configureWithModel(repository)
        return cell
    }

    private func getItem(indexPath: IndexPath) -> Repository {
        return viewModel.items[indexPath.row]
    }
}

extension RepositoryTableViewCell: Configurable {
    func configureWithModel(_ repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
    }
}
