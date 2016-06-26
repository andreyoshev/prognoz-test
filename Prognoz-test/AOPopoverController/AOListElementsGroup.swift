//
//  AOListElementsGroup.swift
//  Prognoz-test
//
//  Created by Андрей Ошев on 26.06.16.
//  Copyright © 2016 Andrey Oshev. All rights reserved.
//

import Foundation

class AOListElementsGroup {
    var title: String?
    var elements: [AOListElement] = []
    
    func addElement(element: AOListElement) {
        elements.append(element)
    }
}