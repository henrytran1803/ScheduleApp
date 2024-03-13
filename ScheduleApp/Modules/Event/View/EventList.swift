//
//  EventList.swift
//  ScheduleApp
//
//  Created by Tran Viet Anh on 11/03/2024.
//

import SwiftUI

struct EventList: View {
    @ObservedObject var eventData: EventData
    @State private var isAddingNewEvent = false
    @State private var newEvent = Event()
    
    @State private var selection: Event?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(Period.allCases) { period in
                    Section(content: {
                        ForEach(eventData.sortedEvents(period: period)) { $event in
                            EventRow(event: event)
                                .tag(event)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        selection = nil
                                        eventData.remove(event)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }, header: {
                        Text(period.name)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    })
                    .disabled(eventData.sortedEvents(period: period).isEmpty)
                }
            }
            .navigationTitle("Schedule App")
            .toolbar {
                ToolbarItem {
                    Button {
                        newEvent = Event()
                        isAddingNewEvent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingNewEvent) {
                NavigationStack {
                    EventEditor(event: $newEvent, isNew: true)
                        .toolbar {
                               ToolbarItem(placement: .cancellationAction) {
                                   Button("Cancel") {
                                       isAddingNewEvent = false
                                   }
                               }
                               ToolbarItem {
                                   Button {
                                       eventData.add(newEvent)
                                       isAddingNewEvent = false
                                   } label: {
                                       Text("Add" )
                                   }
                                   .disabled(newEvent.title.isEmpty)
                               }
                            }
                }
            }
        } detail: {
            ZStack {
                if let event = selection, let eventBinding = eventData.getBindingToEvent(event) {
                    EventEditor(event: eventBinding)
                } else {
                    Text("Select an Event")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList(eventData: EventData())
    }
}
