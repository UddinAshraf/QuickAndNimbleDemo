//
//  Nibable.swift
//  QuickAndNimbleDemo
//
//  Created by Ashraf on 4/21/19.
//  Copyright © 2019 BS23. All rights reserved.
//

//
//  Nibable.swift
//  Tise
//
//  Created by Oscar Apeland on 26.10.2017.
//  Copyright © 2017 Tise. All rights reserved.
//

import Foundation
import UIKit

protocol Dequeueable {}
extension UICollectionReusableView: Dequeueable {}
extension UITableViewCell: Dequeueable {}

/**
 A convenience protocol to register and instaniate cells from an XIB programatically cleaner than the native function calls.
 */
protocol Nibable: class where Self: Dequeueable {
    /// The reuse identifier to register for / dequeue with
    static var id: String { get }
    
    /// The name of the .xib file. Must contains ONE top level UICollectionViewCell view with its reuseIdentifier set to equal the id provided to this protocol.
    static var nibName: String { get }
}

extension Nibable {
    static var nibName: String { return id }
}

extension UICollectionView {
    /**
     Convenience function to register a UICollectionViewCell subclass which conforms to Nibable.
     
     - parameter cellClass: Class of the cell to register.
     - parameter ofKind: An optional parameter to indicate that we should dequeue a supplementary reusable view.
     */
    func register<CellClass: Nibable>(_ cellClass: CellClass.Type, ofKind kind: String? = nil) {
        if let kind = kind {
            register(UINib(nibName: cellClass.nibName, bundle: nil),
                     forSupplementaryViewOfKind: kind,
                     withReuseIdentifier: cellClass.id)
        } else if Bundle.main.path(forResource: cellClass.nibName, ofType: "nib") != nil {
            register(UINib(nibName: cellClass.nibName, bundle: nil),
                     forCellWithReuseIdentifier: cellClass.id)
        } else if let collectionViewCellClass = cellClass as? UICollectionViewCell.Type {
            register(collectionViewCellClass, forCellWithReuseIdentifier: cellClass.id)
        }
    }
    
    /**
     Convenience function to dequeue a UICollectionViewCell from a subclass which conforms to Nibable.
     
     **Important**
     This function force unwraps the result and will crash if the cell class doesn't properly conform to Nibable.
     
     - parameter cellClass: Class of the cell to dequeue.
     - parameter ofKind: An optional parameter to indicate that we should dequeue a supplementary reusable view.
     - parameter indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
     
     - returns: A dequeued cell cast to the Nibable conformist.
     */
    func dequeue<CellClass: Nibable>(_ cellClass: CellClass.Type, ofKind kind: String? = nil, for indexPath: IndexPath) -> CellClass {
        if let kind = kind {
            return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellClass.id, for: indexPath) as! CellClass
        } else {
            return dequeueReusableCell(withReuseIdentifier: cellClass.id, for: indexPath) as! CellClass
        }
    }
}

extension UITableView {
    /**
     Convenience function to register a UITableViewCell subclass which conforms to Nibable.
     
     - parameter cellClass: Class of the cell to register.
     */
    func register<CellClass: Nibable>(_ cellClass: CellClass.Type) {
        if Bundle.main.path(forResource: cellClass.nibName, ofType: "nib") != nil {
            register(UINib(nibName: cellClass.nibName, bundle: nil), forCellReuseIdentifier: cellClass.id)
        } else if let tableViewCellClass = cellClass as? UITableViewCell.Type {
            register(tableViewCellClass, forCellReuseIdentifier: cellClass.id)
        }
    }
    
    /**
     Convenience function to dequeue a UITableViewCell from a subclass which conforms to Nibable.
     
     **Important**
     This function force unwraps the result and will crash if the cell class doesn't properly conform to Nibable.
     
     - parameter cellClass: Class of the cell to dequeue.
     - parameter indexPath: The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
     
     - returns: A dequeued cell cast to the Nibable conformist.
     */
    func dequeue<CellClass: Nibable>(_ cellClass: CellClass.Type, for indexPath: IndexPath) -> CellClass {
        return dequeueReusableCell(withIdentifier: cellClass.id, for: indexPath) as! CellClass
    }
}
