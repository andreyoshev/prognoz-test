//
//  AOListSelector.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

protocol AOListSelector {
    var cellMinHeight: CGFloat { get set }
    var cellFont: UIFont { get set }
    var cellTextColor: UIColor { get set }
    var cellBackgroundColor: UIColor { get set }
    
    var showSearch: Bool { get set }
    var multiSelect: Bool { get set }
    var headerComment: String? { get set }
    var bottomComment: String? { get set }
    
    var headerCommentFont: UIFont { get set }
    var headerCommentTextColor: UIColor { get set }
    var headerCommentBackgroundColor: UIColor { get set }
    
    var bottomCommentFont: UIFont { get set }
    var bottomCommentTextColor: UIColor { get set }
    var bottomCommentBackgroundColor: UIColor { get set }
    
    var closeButtonTitle: String? { get set }
    
    var selectAllButtonTitle: String? { get set }
    var deselectAllButtonTitile: String? { get set }
    
    weak var dataSource: AOListSelectorDataSource? { get set }
    weak var selectorDelegate: AOListSelectorDelegate? { get set }
    
    func reloadData()
}