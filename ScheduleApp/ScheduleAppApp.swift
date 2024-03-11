//
//  ScheduleAppApp.swift
//  ScheduleApp
//
//  Created by Tran Viet Anh on 11/03/2024.
//

import SwiftUI
import SwiftData

@main
struct ScheduleAppApp: App {
    
    @StateObject private var eventData = EventData()
    var body: some Scene {
         WindowGroup {
             EventList(eventData: eventData)

         }
     }}
