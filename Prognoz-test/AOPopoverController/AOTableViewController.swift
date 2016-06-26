//
//  AOTableViewController.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

enum commentLoc {
    case header
    case bottom
}

class AOTableViewController: UIViewController, AOListSelector {
    var tableView: UITableView!
    var tableViewStyle: UITableViewStyle = .Plain
    
    var cellMinHeight: CGFloat = 44
    var cellFont: UIFont = UIFont.systemFontOfSize(17)
    var cellTextColor: UIColor = UIColor.blackColor()
    var cellBackgroundColor: UIColor = UIColor.whiteColor()
    
    var showSearch: Bool = false
    var headerComment: String? {
        didSet {
            if (headerComment != nil) {
                headerCommentLabel!.text = headerComment
                tableView.setAndLayoutTableCommentView(headerCommentLabel!, location: .header)
            }
            else {
                tableView.tableHeaderView = nil
            }
        }
    }
    var bottomComment: String? {
        didSet {
            if (bottomComment != nil) {
                bottomCommentLabel!.text = bottomComment
                tableView.setAndLayoutTableCommentView(bottomCommentLabel!, location: .bottom)
            }
            else {
                tableView.tableFooterView = nil
            }
        }
    }
    
    var headerCommentFont: UIFont = UIFont.systemFontOfSize(17) {
        didSet {
            headerCommentLabel?.font = headerCommentFont
        }
    }
    var headerCommentTextColor: UIColor = UIColor.blackColor() {
        didSet {
            headerCommentLabel?.textColor = headerCommentTextColor
        }
    }
    var headerCommentBackgroundColor: UIColor = UIColor.blackColor() {
        didSet {
            headerCommentLabel?.backgroundColor = headerCommentTextColor
        }
    }
    
    var bottomCommentFont: UIFont = UIFont.systemFontOfSize(14) {
        didSet {
            bottomCommentLabel?.font = headerCommentFont
        }
    }
    var bottomCommentTextColor: UIColor = UIColor.blackColor() {
        didSet {
            bottomCommentLabel?.textColor = bottomCommentTextColor
        }
    }
    var bottomCommentBackgroundColor: UIColor = UIColor.whiteColor() {
        didSet {
            bottomCommentLabel?.backgroundColor = bottomCommentBackgroundColor
        }
    }
    
    var headerCommentLabel: UILabel?
    var bottomCommentLabel: UILabel?
    
    weak var dataSource: AOListSelectorDataSource?
    
    var shouldShowIcons: Bool = false
    var iconsSize: CGSize = CGSizeZero
    
    init(style: UITableViewStyle) {
        super.init(nibName: nil, bundle: nil)
        tableViewStyle = style
        self.createTableViewWithStyle(tableViewStyle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createTableViewWithStyle(tableViewStyle)
    }
    
    func createTableViewWithStyle(style: UITableViewStyle) {
        tableView = UITableView(frame: CGRectZero, style: style)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(AOListElementCell.self, forCellReuseIdentifier: AOListElementCell.cellIdentifier())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        headerCommentLabel = UILabel()
        headerCommentLabel?.numberOfLines = 0
        bottomCommentLabel = UILabel()
        bottomCommentLabel?.numberOfLines = 0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - AOListSelector
    
    func reloadData() {
        var showIcons: Bool = false
        iconsSize = CGSizeZero
        
        if (dataSource != nil) {
            for section in 0..<dataSource!.numberOfSectionsInListSelector(self) {
                for row in 0..<dataSource!.listSelector(self, numberOfRowsInSection: section) {
                    let element = dataSource!.listSelector(self, elementAtIndexPath: NSIndexPath(forRow: row, inSection: section))
                    if (element.image != nil) {
                        showIcons = true
                        iconsSize = element.image!.size
                    }
                }
            }
        }
        
        shouldShowIcons = showIcons
        
        tableView.reloadData()
    }
}

extension AOTableViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let _ = dataSource
            else { return 0 }
        return dataSource!.numberOfSectionsInListSelector(self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = dataSource
            else { return 0 }
        return dataSource!.listSelector(self, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AOListElementCell.cellIdentifier()) as! AOListElementCell
        
        if let element = dataSource?.listSelector(self, elementAtIndexPath: indexPath) as AOListElement! {
            cell.configureWithElement(element)
        }
        
        cell.showIcon = shouldShowIcons
        cell.iconSize = iconsSize
        cell.titleLabel.font = cellFont
        cell.titleLabel.textColor = cellTextColor
        cell.contentView.backgroundColor = cellBackgroundColor
        
        return cell
    }
}

extension AOTableViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = cellMinHeight
        
        if let element = dataSource?.listSelector(self, elementAtIndexPath: indexPath) as AOListElement! {
            let cellHeight = AOListElementCell.heightForElement(element, iconSize: iconsSize, titleFont: cellFont, cellWidth: tableView.bounds.width)
            height = max(cellHeight, height)
        }
        
        return height
    }
}

extension UITableView {
    func setAndLayoutTableCommentView(comment: UIView, location: commentLoc) {
        (location == .header) ? (tableHeaderView = comment) : (tableFooterView = comment)
        comment.setNeedsLayout()
        comment.layoutIfNeeded()
        let height = comment.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        var frame = comment.frame
        frame.size.height = height
        comment.frame = frame
        (location == .header) ? (tableHeaderView = comment) : (tableFooterView = comment)
    }
}



















