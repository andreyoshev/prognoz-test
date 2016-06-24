//
//  ViewController.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var elements = [AOListElement]()
    
    // MARK: - IBAction
    
    @IBAction func showPopover(sender: UIButton) {
        let popover = AOPopoverController(tableViewStyle: .Plain)
        popover.presentPopoverFromRect(sender.frame, inView: view, permittedArrowDirections: .Unknown, animated: true)
        popover.dataSource = self
        popover.cellTextColor = UIColor.redColor()
        popover.cellBackgroundColor = UIColor.greenColor()
        popover.cellFont = UIFont.systemFontOfSize(20)
        popover.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadElements()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadElements() {
        for i in 0..<10 {
            let element = AOListElement()
            element.text = "\(i)"
            let name = String(format: "icon_1_%02d", i+1)
            print(name)
            element.image = UIImage(named: name)
            elements.append(element)
        }
        
        let element = AOListElement()
        element.text = "TEXT \n TEXT \n TEXT \n TEXT \n TEXT \n TEXT"
        elements.append(element)
    }
}

extension ViewController: AOListSelectorDataSource {
    func numberOfSectionsInListSelector(listSelector: AOListSelector) -> Int {
        return 1
    }
    
    func listSelector(listSelector: AOListSelector, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func listSelector(listSelector: AOListSelector, elementAtIndexPath indexPath: NSIndexPath) -> AOListElement {
        return elements[indexPath.row]
    }
}

