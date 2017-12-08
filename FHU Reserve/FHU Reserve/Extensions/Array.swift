//
//  Array.swift
//  FHU Reserve
//
//  Created by Keith Mattix on 12/7/17.
//  Copyright © 2017 Freed Hardeman University. All rights reserved.
//

import Foundation
public extension Array {
    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}
