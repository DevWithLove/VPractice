//
//  UserInfoView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import UIKit

class UserInfoView: UIView {
    
    // MARK:- Constants
    private let profileImageDimension: CGFloat = 60
    private let spacing: CGFloat = 8
    
    // MARK:- UI Elements
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = profileImageDimension / 2
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var detailView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [usernameLabel, emailLabel])
        view.axis = .vertical
        view.spacing = spacing
        view.distribution = .fill
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileImageView)
        addSubview(detailView)
        
        profileImageView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(profileImageDimension)
        }
        
        detailView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(spacing)
        }
    }
}
