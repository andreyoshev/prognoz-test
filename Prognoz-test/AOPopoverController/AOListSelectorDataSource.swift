//
//  AOListSelectorDataSource.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 23.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import Foundation

protocol AOListSelectorDataSource: class {
    func listSelectorElementsGroups(listSelector: AOListSelector) -> [AOListElementsGroup]
}