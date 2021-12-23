//
//  RepositoryTableViewCell.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    // MARK:- Constants
    private let nameFont = UIFont.boldSystemFont(ofSize: 20)
    private let elementSpace: CGFloat = 5
    private let padding: CGFloat = 20
    
    // MARK:- UI Elements
   
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = nameFont
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var detailView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        view.axis = .vertical
        view.spacing = elementSpace
        view.distribution = .fill
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
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private func setupUI() {
        contentView.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(padding)
            make.bottom.trailing.equalToSuperview().offset(-padding)
        }
    }
}
