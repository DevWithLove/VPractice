//
//  RepositoryListHostingViewController.swift
//  VacasaPractice
//
//  Created by Tony Mu on 17/01/22.
//

import UIKit
import SwiftUI

class RepositoryListHostingViewController: UIViewController {

    let contentView = UIHostingController(rootView: RepositoryListView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentView)
        view.addSubview(contentView.view)
        
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
