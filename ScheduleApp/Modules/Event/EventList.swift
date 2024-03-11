//
//  EventList.swift
//  ScheduleApp
//
//  Created by Tran Viet Anh on 11/03/2024.
//

import SwiftUI
//#-learning-task(eventList)

/*#-code-walkthrough(5.eventList)*/
struct EventList: View {
    /*#-code-walkthrough(5.eventList)*/
    /*#-code-walkthrough(5.eventData)*/
    @ObservedObject var eventData: EventData
    /*#-code-walkthrough(5.eventData)*/
    @State private var isAddingNewEvent = false
    @State private var newEvent = Event()
    
    @State private var selection: Event?
    
    var body: some View {
        /*#-code-walkthrough(5.navSplitView)*/
        NavigationSplitView {
            /*#-code-walkthrough(5.navSplitView)*/
            /*#-code-walkthrough(5.listForEach)*/
            List(selection: $selection) {
                ForEach(Period.allCases) { period in
                    /*#-code-walkthrough(5.listForEach)*/
                    /*#-code-walkthrough(5.listSection)*/
                    Section(content: {
                        ForEach(eventData.sortedEvents(period: period)) { $event in
                            /*#-code-walkthrough(5.listSection)*/
                            /*#-code-walkthrough(5.eventView)*/
                            EventRow(event: event)
                                .tag(event)
                            /*#-code-walkthrough(5.deleteEvents)*/
                                .swipeActions {
                                    Button(role: .destructive) {
                                        selection = nil
                                        eventData.remove(event)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            /*#-code-walkthrough(5.deleteEvents)*/
                            /*#-code-walkthrough(5.eventView)*/
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
            .navigationTitle("Date Planner")
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
        /*#-code-walkthrough(5.navSplitViewDetails)*/
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
        /*#-code-walkthrough(5.navSplitViewDetails)*/
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList(eventData: EventData())
    }
}
