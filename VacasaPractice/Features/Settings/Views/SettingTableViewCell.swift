//
//  SettingTableViewCell.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    // MARK:- Constants
    private let elementSpace: CGFloat = 5
    private let padding: CGFloat = 8
    private let largePadding: CGFloat = 20
    
    // MARK:- UI Elements
   
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.isHidden = true
        label.textAlignment = .right
        return label
    }()
    
    lazy var switchControl: UISwitch = {
        let view = UISwitch()
        view.isOn = false
        view.isHidden = true
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        infoLabel.text = nil
        infoLabel.isHidden = true
        switchControl.isOn = false
        switchControl.isHidden = true
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(switchControl)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(largePadding)
            make.bottom.equalToSuperview().offset(-padding)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.trailing).offset(elementSpace)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-largePadding)
        }
        switchControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.trailing).offset(elementSpace)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-largePadding)
        }
    }
}

