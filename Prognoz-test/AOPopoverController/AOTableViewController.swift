//
//  AOTableViewController.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

enum AOTableViewCommentLocation {
    case Header
    case Bottom
}

class AOTableViewController: UIViewController, AOListSelector {
    var tableView: UITableView!
    var tableViewStyle: UITableViewStyle = .Plain
    var elementsGroups: [AOListElementsGroup]?
    
    // MARK: - AOListSelector
    
    var cellMinHeight: CGFloat = 44
    var cellFont: UIFont = UIFont.systemFontOfSize(17)
    var cellTextColor: UIColor = UIColor.blackColor()
    var cellBackgroundColor: UIColor = UIColor.whiteColor()
    
    var showSearch: Bool = false {
        didSet {
            if (searchBar != nil) {
                searchBar?.hidden = !showSearch
            }
            viewDidLayoutSubviews()
        }
    }
    var searchBar: UISearchBar?
    
    var headerComment: String? {
        didSet {
            if (headerComment != nil && headerCommentLabel != nil) {
                headerCommentLabel!.text = headerComment
                tableView.setAndLayoutTableCommentView(headerCommentLabel!, location: .Header)
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
                tableView.setAndLayoutTableCommentView(bottomCommentLabel!, location: .Bottom)
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
                tableView.setAndLayoutTableCommentView(headerCommentLabel!, location: .Header)
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
                tableView.setAndLayoutTableCommentView(bottomCommentLabel!, location: .Bottom)
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
    
    // MARK: - Life Cycle
    
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
        
        searchBar = UISearchBar()
        searchBar?.hidden = !showSearch
        
        
        view.addSubview(searchBar!)
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
            tableView.setAndLayoutTableCommentView(headerCommentLabel!, location: .Header)
        }
        bottomCommentLabel = UILabel()
        bottomCommentLabel?.numberOfLines = 0
        bottomCommentLabel?.textAlignment = .Center
        bottomCommentLabel?.font = bottomCommentFont
        bottomCommentLabel?.textColor = bottomCommentTextColor
        bottomCommentLabel?.backgroundColor = bottomCommentBackgroundColor
        if (bottomComment != nil) {
            bottomCommentLabel!.text = bottomComment
            tableView.setAndLayoutTableCommentView(bottomCommentLabel!, location: .Bottom)
        }
    }
    
    func closeAction() {
        selectorDelegate?.listSelectorCloseAction(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tableViewY: CGFloat = 44
        searchBar?.frame = CGRectMake(0, 44, view.bounds.width, 44)
        if (showSearch && searchBar != nil) {
            tableViewY = searchBar!.frame.maxY
        }
        
        tableView.frame = CGRectMake(0, tableViewY, view.bounds.width, view.bounds.height - tableViewY)
    }
    
    // MARK: - AOListSelector
    
    func reloadData() {
        var showIcons: Bool = false
        iconsSize = CGSizeZero
        elementsGroups = dataSource?.listSelectorElementsGroups(self)
        
        if (elementsGroups != nil) {
            for section in 0..<elementsGroups!.count {
                let group: AOListElementsGroup = elementsGroups![section]
                for row in 0..<group.elements.count {
                    let element = group.elements[row]
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
    
    func elementAtIndexPath(indexPath: NSIndexPath) -> AOListElement? {
        return (elementsGroups?[indexPath.section])?.elements[indexPath.row]
    }
}

extension AOTableViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let _ = elementsGroups
            else { return 0 }
        return elementsGroups!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = elementsGroups
            else { return 0 }
        return (elementsGroups![section]).elements.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AOListElementCell.cellIdentifier()) as! AOListElementCell
        
        if let element = elementAtIndexPath(indexPath) as AOListElement! {
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
        
        if let element = elementAtIndexPath(indexPath) as AOListElement! {
            let cellHeight = AOListElementCell.heightForElement(element, iconSize: iconsSize, titleFont: cellFont, cellWidth: tableView.bounds.width)
            height = max(cellHeight, height)
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return elementsGroups?[section].title
    }
}

extension UITableView {
    func setAndLayoutTableCommentView(commentView: UIView, location: AOTableViewCommentLocation) {
        setTableViewCommentLocation(commentView, location: location)
        commentView.setNeedsLayout()
        commentView.layoutIfNeeded()
        let height = commentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        var frame = commentView.frame
        frame.size.height = height
        commentView.frame = frame
        setTableViewCommentLocation(commentView, location: location)
    }
    
    func setTableViewCommentLocation(commentView: UIView, location: AOTableViewCommentLocation) {
        switch location {
        case .Header:
            tableHeaderView = commentView
        case .Bottom:
            tableFooterView = commentView
        }
    }
}