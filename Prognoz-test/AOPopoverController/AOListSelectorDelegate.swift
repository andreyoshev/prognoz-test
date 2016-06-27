//
//  AOListSelectorDelegate.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 26.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import Foundation

protocol AOListSelectorDelegate: class {
    func listSelectorCloseAction(listSelector: AOListSelector)
    func listSelector(listSelector: AOListSelector, didSelectElementsWithIDs IDs: [Int])
}