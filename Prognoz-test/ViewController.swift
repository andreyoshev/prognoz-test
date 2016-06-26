//
//  ViewController.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var groupsOne = [AOListElementsGroup]()
    var popover: AOPopoverController?
    
    @IBAction func showPopover(sender: UIButton) {
        popover = AOPopoverController(tableViewStyle: .Plain)
        popover!.presentPopoverFromRect(sender.frame, inView: view, permittedArrowDirections: .Unknown, animated: true)
        
        popover!.dataSource = self
        popover!.selectorDelegate = self
        
        popover!.showSearch = true
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
        for i in 0..<2 {
            let group = AOListElementsGroup()
            group.title = "Section \(i)"
            for j in 0..<10 {
                let element = AOListElement()
                element.text = "Section: \(i), Row: \(j)"
                let name = String(format: "icon_%d_%02d", i+1, j+1)
                element.image = UIImage(named: name)
                group.addElement(element)
            }
            groupsOne.append(group)
        }
    }
}

extension ViewController: AOListSelectorDataSource {
    func listSelectorElementsGroups(listSelector: AOListSelector) -> [AOListElementsGroup] {
        return groupsOne
    }
}

extension ViewController: AOListSelectorDelegate {
    func listSelectorCloseAction(listSelector: AOListSelector) {
        if let ls = listSelector as? AOPopoverController {
            ls.dismissPopoverAnimated(true)
        }
    }
}

















