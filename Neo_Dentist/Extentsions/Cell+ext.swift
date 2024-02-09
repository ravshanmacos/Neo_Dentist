//
//  UITableView+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

extension UITableViewCell {
    static func makeReuseIdentifier()->String {
        return String(describing: self)
    }
    
    static func register(to tableView: UITableView, reuseIdentifier:String? = nil) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier ?? makeReuseIdentifier())
    }
    
    static func dequeue(on tableView: UITableView, at indexPath: IndexPath) -> Self? {
        return tableView.dequeueReusableCell(withIdentifier: makeReuseIdentifier(), for: indexPath) as? Self
    }
}

extension UICollectionViewCell {
    static func makeReuseIdentifier()->String {
        return String(describing: self)
    }
    
    static func register(to collectionView: UICollectionView, reuseIdentifier:String? = nil) {
        collectionView.register(self, forCellWithReuseIdentifier: reuseIdentifier ?? makeReuseIdentifier())
    }
    
    static func dequeue(on collectionView: UICollectionView, at indexPath: IndexPath) -> Self? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: makeReuseIdentifier(), for: indexPath) as? Self
    }
}


