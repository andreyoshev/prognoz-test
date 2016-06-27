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
    
    var singleSelectPopover: AOPopoverController?
    var multiSelectPopover: AOPopoverController?
    @IBOutlet weak var multiLabel: UILabel!
    @IBOutlet weak var singleLabel: UILabel!
    
    // MARK: - IBActions
    
    @IBAction func showPopoverSingleSelect(sender: UIButton) {
        singleSelectPopover = AOPopoverController(tableViewStyle: .Plain)
        singleSelectPopover!.presentPopoverFromRect(sender.frame, inView: view, permittedArrowDirections: .Unknown, animated: true)
        
        singleSelectPopover!.dataSource = self
        singleSelectPopover!.selectorDelegate = self
        
        singleSelectPopover!.showSearch = false
        singleSelectPopover!.multiSelect = false
        
        singleSelectPopover!.cellTextColor = UIColor.redColor()
        singleSelectPopover!.cellBackgroundColor = UIColor.cyanColor()
        singleSelectPopover!.cellFont = UIFont.systemFontOfSize(20)
        
        singleSelectPopover!.headerComment = "Header Comment 2"
        singleSelectPopover!.headerCommentTextColor = UIColor.redColor()
        singleSelectPopover!.headerCommentBackgroundColor = UIColor.yellowColor()
        singleSelectPopover!.headerCommentFont = UIFont.boldSystemFontOfSize(23)
        
        singleSelectPopover!.bottomComment = "Bottom Comment 2"
        
        singleSelectPopover!.title = "SingleSelect"
        singleSelectPopover!.closeButtonTitle = "Close 2"
        
        singleSelectPopover!.reloadData()
    }
    
    @IBAction func showPopoverMultiSelect(sender: UIButton) {
        multiSelectPopover = AOPopoverController(tableViewStyle: .Grouped)
        multiSelectPopover!.presentPopoverFromRect(sender.frame, inView: view, permittedArrowDirections: .Unknown, animated: true)
        
        multiSelectPopover!.dataSource = self
        multiSelectPopover!.selectorDelegate = self
        
        multiSelectPopover!.showSearch = true
        multiSelectPopover!.multiSelect = true
        
        multiSelectPopover!.cellTextColor = UIColor.redColor()
        multiSelectPopover!.cellBackgroundColor = UIColor.greenColor()
        multiSelectPopover!.cellFont = UIFont.systemFontOfSize(20)
        
        multiSelectPopover!.headerComment = "Header Comment 1"
        multiSelectPopover!.headerCommentTextColor = UIColor.redColor()
        multiSelectPopover!.headerCommentBackgroundColor = UIColor.yellowColor()
        multiSelectPopover!.headerCommentFont = UIFont.boldSystemFontOfSize(23)
        
        multiSelectPopover!.selectAllButtonTitle = "Выбрать все"
        multiSelectPopover!.deselectAllButtonTitile = "Снять выбор"
        multiSelectPopover!.bottomComment = "Bottom Comment 1"
        
        multiSelectPopover!.title = "MultiSelect"
        multiSelectPopover!.closeButtonTitle = "Close 1"
        
        multiSelectPopover!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElements()
    }

    func loadElements() {
        for i in 0..<2 {
            let group = AOListElementsGroup()
            group.title = "Section \(i)"
            for j in 0..<16 {
                let element = AOListElement()
                element.identifier = 1000 * i + j
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
    
    func listSelector(listSelector: AOListSelector, didSelectElementsWithIDs IDs: [Int]) {
        guard let popover = listSelector as? AOPopoverController
            else { return }
        
        var title: String = ""
        
        for ID in IDs {
            title = title + "\(ID)" + ", "
        }
        
        if (title.hasSuffix(", ")) {
            title = title.substringToIndex(title.endIndex.advancedBy(-2))
        }
        
        if (title.characters.count == 0) {
            title = "No elements selected"
        }
        
        if (popover == singleSelectPopover) {
            singleLabel.text = title
        } else if (popover == multiSelectPopover) {
            multiLabel.text = title
        }
    }
}

















