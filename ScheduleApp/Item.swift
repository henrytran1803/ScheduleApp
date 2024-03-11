//
//  Item.swift
//  ScheduleApp
//
//  Created by Tran Viet Anh on 11/03/2024.
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
