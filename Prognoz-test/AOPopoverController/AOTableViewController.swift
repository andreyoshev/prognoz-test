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
            if (headerComment != nil && headerCommentLabel != nil) {
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
            if (bottomComment != nil && bottomCommentLabel != nil) {
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
            if (headerComment != nil && headerCommentLabel != nil) {
                tableView.setAndLayoutTableCommentView(headerCommentLabel!, location: .header)
            }
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
            if (bottomComment != nil && bottomCommentLabel != nil) {
                tableView.setAndLayoutTableCommentView(bottomCommentLabel!, location: .bottom)
            }
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
    
    var closeButtonTitle: String? {
        didSet {
            closeButton?.setTitle(closeButtonTitle, forState: .Normal)
        }
    }
    
    var headerCommentLabel: UILabel?
    var bottomCommentLabel: UILabel?
    var closeButton: UIButton?
    
    weak var dataSource: AOListSelectorDataSource?
    weak var selectorDelegate: AOListSelectorDelegate?
    
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
        
        closeButton = UIButton()
        closeButton?.setTitle(closeButtonTitle, forState: .Normal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton!)
        closeButton?.frame = CGRectMake(0, 0, view.bounds.width, 44)
        closeButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        closeButton?.sizeToFit()
        closeButton?.addTarget(self, action: #selector(closeAction), forControlEvents: .TouchUpInside)
        
        headerCommentLabel = UILabel()
        headerCommentLabel?.numberOfLines = 0
        headerCommentLabel?.textAlignment = .Center
        headerCommentLabel?.font = headerCommentFont
        headerCommentLabel?.textColor = headerCommentTextColor
        headerCommentLabel?.backgroundColor = headerCommentBackgroundColor
        if (headerComment != nil) {
            headerCommentLabel!.text = headerComment
            tableView.setAndLayoutTableCommentView(headerCommentLabel!, location: .header)
        }
        bottomCommentLabel = UILabel()
        bottomCommentLabel?.numberOfLines = 0
        bottomCommentLabel?.textAlignment = .Center
        bottomCommentLabel?.font = bottomCommentFont
        bottomCommentLabel?.textColor = bottomCommentTextColor
        bottomCommentLabel?.backgroundColor = bottomCommentBackgroundColor
        if (bottomComment != nil) {
            bottomCommentLabel!.text = bottomComment
            tableView.setAndLayoutTableCommentView(bottomCommentLabel!, location: .bottom)
        }
    }
    
    func closeAction() {
        selectorDelegate?.listSelectorCloseAction(self)
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
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource?.listSelectorTitleForSection(self, section: section)
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