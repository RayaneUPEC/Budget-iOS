//
//  Item.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
