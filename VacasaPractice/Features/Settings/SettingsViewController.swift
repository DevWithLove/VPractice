//
//  SettingsViewController.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var viewModel: SettingsViewModelProtocol!
    
    private lazy var userInfoView: UserInfoView = {
        let view = UserInfoView(frame: .zero)
        view.config(with: viewModel.user)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.regisger(cellClass: SettingTableViewCell.self)
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadData()
    }
    
    private func setup() {
        viewModel = SettingsViewModel()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
        view.addSubview(userInfoView)
        view.addSubview(tableView)
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func didLoadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.groupedOptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groupedOptions[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellId, for: indexPath) as! SettingTableViewCell
        let setting = getSettingOption(indexPath: indexPath)
        cell.configureWithModel(setting)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.groupedOptions[section].sectionItem.description.uppercased()
    }
    
    private func getSettingOption(indexPath: IndexPath) -> SettingOption {
        return viewModel.groupedOptions[indexPath.section].rows[indexPath.row]
    }
}

extension SettingTableViewCell: Configurable {
    func configureWithModel(_ setting: SettingOption) {
        titleLabel.text = setting.title
        if let readOnlyOption = setting as? ReadOnlySettingOption {
            infoLabel.text = readOnlyOption.value
            infoLabel.isHidden = false
            return
        }
        if let switchOption = setting as? SwitchSettingOption {
            switchControl.isOn = switchOption.value
            switchControl.isHidden = false
        }
    }
}

private extension UserInfoView {
    func config(with user: UserInfo) {
        emailLabel.text = user.email
        usernameLabel.text = user.name
        profileImageView.image = UIImage(named: user.profileImageName)
    }
}
