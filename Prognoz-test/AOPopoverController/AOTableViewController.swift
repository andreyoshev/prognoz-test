//
//  AOTableViewController.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

class AOTableViewController: UIViewController, AOListSelector {
    var tableView: UITableView!
    var tableViewStyle: UITableViewStyle = .Plain
    
    var cellMinHeight: CGFloat = 44
    var cellFont: UIFont = UIFont.systemFontOfSize(14)
    var cellTextColor: UIColor = UIColor.blackColor()
    var cellBackgroundColor: UIColor = UIColor.whiteColor()
    
    var showSearch: Bool = false
    var headerComment: String?
    var bottomComment: String?
    
    var headerCommentFont: UIFont = UIFont.systemFontOfSize(14)
    var headerCommentTextColor: UIColor = UIColor.blackColor()
    var headerCommentBackgroundColor: UIColor = UIColor.blackColor()
    
    var bottomCommentFont: UIFont = UIFont.systemFontOfSize(14)
    var bottomCommentTextColor: UIColor = UIColor.blackColor()
    var bottomCommentBackgroundColor: UIColor = UIColor.whiteColor()
    
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
        tableView.registerClass(AOListElementCell.self, forCellReuseIdentifier: AOListElementCell.cellIdentifier())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
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
