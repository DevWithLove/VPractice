//
//  TableViewCellExtensions.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import UIKit

extension UITableView {
    func regisger<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.cellId)
    }
    
    func regisger<T: UITableViewHeaderFooterView>(viewClass: T.Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.cellId)
    }
}

extension UITableViewCell {
    static var cellId: String {
        return String(describing: self).lowercased()
    }
}

extension UITableViewHeaderFooterView {
    static var cellId: String {
        return String(describing: self).lowercased()
    }
}
