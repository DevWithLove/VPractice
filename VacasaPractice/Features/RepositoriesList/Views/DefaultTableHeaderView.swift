//
//  DefaultTableHeaderView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import UIKit

class DefaultTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK:- Constants
    private let nameFont = UIFont.boldSystemFont(ofSize: 30)
    private let padding: CGFloat = 20
    
    // MARK:- UI Elements
   
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = nameFont
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(padding)
            make.bottom.trailing.equalToSuperview().offset(-padding)
        }
    }
}
