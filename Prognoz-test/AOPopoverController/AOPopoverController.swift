//
//  AOPopoverController.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

class AOPopoverController: UIPopoverController, AOListSelector {
    
    var tableViewController: AOTableViewController!
    
    // MARK: - AOListSelector Properties
    
    var cellMinHeight: CGFloat {
        get {
            return tableViewController.cellMinHeight
        }
        set(height) {
            tableViewController.cellMinHeight = height
        }
    }
    var cellFont: UIFont {
        get {
            return tableViewController.cellFont
        }
        set(font) {
            tableViewController.cellFont = font
        }
    }
    var cellTextColor: UIColor {
        get {
            return tableViewController.cellTextColor
        }
        set(color) {
            tableViewController.cellTextColor = color
        }
    }
    var cellBackgroundColor: UIColor {
        get {
            return tableViewController.cellBackgroundColor
        }
        set(color) {
            tableViewController.cellBackgroundColor = color
        }
    }
    
    var showSearch: Bool {
        get {
            return tableViewController.showSearch
        }
        set(show) {
            tableViewController.showSearch = show
        }
    }
    var headerComment: String? {
        get {
            return tableViewController.headerComment
        }
        set(comment) {
            tableViewController.headerComment = comment
        }
    }
    var bottomComment: String? {
        get {
            return tableViewController.bottomComment
        }
        set(comment) {
            tableViewController.bottomComment = comment
        }
    }
    
    var headerCommentFont: UIFont {
        get {
            return tableViewController.headerCommentFont
        }
        set(font){
            tableViewController.headerCommentFont = font
        }
    }
    var headerCommentTextColor: UIColor {
        get {
            return tableViewController.headerCommentTextColor
        }
        set(color) {
            tableViewController.headerCommentTextColor = color
        }
    }
    var headerCommentBackgroundColor: UIColor {
        get {
            return tableViewController.headerCommentBackgroundColor
        }
        set(color) {
            tableViewController.headerCommentBackgroundColor = color
        }
    }
    
    var bottomCommentFont: UIFont {
        get {
            return tableViewController.bottomCommentFont
        }
        set(font) {
            tableViewController.bottomCommentFont = font
        }
    }
    var bottomCommentTextColor: UIColor {
        get {
            return tableViewController.bottomCommentTextColor
        }
        set(color) {
            tableViewController.bottomCommentTextColor = color
        }
    }
    var bottomCommentBackgroundColor: UIColor {
        get {
            return tableViewController.bottomCommentBackgroundColor
        }
        set(color) {
            tableViewController.bottomCommentBackgroundColor = color
        }
    }
    
    weak var dataSource: AOListSelectorDataSource? {
        didSet {
            tableViewController.dataSource = dataSource
        }
    }
    
    class func createTableViewControllerWithTableViewStyle(tableViewStyle: UITableViewStyle) -> AOTableViewController {
        let tableVC = AOTableViewController(style: tableViewStyle)
        return tableVC
    }
    
    init(tableViewStyle: UITableViewStyle) {
        let tableVC = self.dynamicType.createTableViewControllerWithTableViewStyle(tableViewStyle)
        super.init(contentViewController: tableVC)
        tableViewController = tableVC
        tableViewController.dataSource = self.dataSource
    }
    
    func reloadData() {
        tableViewController.reloadData()
    }
}
