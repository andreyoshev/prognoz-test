//
//  AOListSelectorDataSource.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import Foundation

protocol AOListSelectorDataSource: class {
    func numberOfSectionsInListSelector(listSelector: AOListSelector) -> Int
    func listSelector(listSelector: AOListSelector, numberOfRowsInSection section: Int) -> Int
    func listSelector(listSelector: AOListSelector, elementAtIndexPath indexPath: NSIndexPath) -> AOListElement
}