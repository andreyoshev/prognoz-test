//
//  ViewController.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var elements1 = [AOListElement]()
    var elements2 = [AOListElement]()
    var sectionsTitles = [String]()
    
    var popover: AOPopoverController?
    
    @IBAction func showPopover(sender: UIButton) {
        popover = AOPopoverController(tableViewStyle: .Plain)
        popover!.presentPopoverFromRect(sender.frame, inView: view, permittedArrowDirections: .Unknown, animated: true)
        
        popover!.dataSource = self
        popover!.selectorDelegate = self
        
        popover!.cellTextColor = UIColor.redColor()
        popover!.cellBackgroundColor = UIColor.greenColor()
        popover!.cellFont = UIFont.systemFontOfSize(20)
        popover!.headerComment = "Header Comment"
        popover!.headerCommentTextColor = UIColor.redColor()
        popover!.headerCommentBackgroundColor = UIColor.yellowColor()
        popover!.headerCommentFont = UIFont.boldSystemFontOfSize(23)
        popover!.bottomComment = "Bottom Comment"
        popover!.title = "PopOver Title"
        popover!.closeButtonTitle = "Close"
        
        popover!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElements()
    }

    func loadElements() {
        sectionsTitles.append("Section 1")
        for i in 0..<10 {
            let element = AOListElement()
            element.text = "\(i)"
            let name = String(format: "icon_1_%02d", i+1)
            element.image = UIImage(named: name)
            elements1.append(element)
        }
        
        var element = AOListElement()
        element.text = "TEXT \n TEXT \n TEXT \n TEXT \n TEXT \n TEXT"
        elements1.append(element)
        
        sectionsTitles.append("Section 2")
        for i in 0..<10 {
            let element = AOListElement()
            element.text = "\(i)"
            let name = String(format: "icon_2_%02d", i+1)
            element.image = UIImage(named: name)
            elements2.append(element)
        }
        
        element = AOListElement()
        element.text = "TEXT \n TEXT \n TEXT \n TEXT \n TEXT \n TEXT"
        elements2.append(element)
    }
}

extension ViewController: AOListSelectorDataSource {
    func numberOfSectionsInListSelector(listSelector: AOListSelector) -> Int {
        return 2
    }
    
    func listSelector(listSelector: AOListSelector, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return elements1.count
        } else {
            return elements2.count
        }
    }
    
    func listSelector(listSelector: AOListSelector, elementAtIndexPath indexPath: NSIndexPath) -> AOListElement {
        if (indexPath.section == 0) {
            return elements1[indexPath.row]
        } else {
            return elements2[indexPath.row]
        }
    }
    func listSelectorTitleForSection(listSelector: AOListSelector, section: Int) -> String? {
        return sectionsTitles[section]
    }
}

extension ViewController: AOListSelectorDelegate {
    func listSelectorCloseAction(listSelector: AOListSelector) {
        if let ls = listSelector as? AOPopoverController {
            ls.dismissPopoverAnimated(true)
        }
    }
}

















