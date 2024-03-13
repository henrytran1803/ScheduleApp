//
//  EventTask.swift
//  ScheduleApp
//
//  Created by Tran Viet Anh on 11/03/2024.
//

import Foundation

struct EventTask: Identifiable, Hashable, Codable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
}
