//
//  EventTask.swift
//  ScheduleApp
//
//  Created by Tran Viet Anh on 11/03/2024.
//

import Foundation
//#-learning-task(eventTask)

/*#-code-walkthrough(3.eventTask)*/
struct EventTask: Identifiable, Hashable, Codable {
    /*#-code-walkthrough(3.eventTask)*/
    /*#-code-walkthrough(3.properties)*/
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
    /*#-code-walkthrough(3.properties)*/
}
