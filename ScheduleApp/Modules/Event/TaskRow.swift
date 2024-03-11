//
//  TaskRow.swift
//  ScheduleApp
//
//  Created by Tran Viet Anh on 11/03/2024.
//

import SwiftUI

struct TaskRow: View {
    @Binding var task: EventTask
    var focusedTask: FocusState<EventTask?>.Binding

    var body: some View {
        HStack {
            Button {
                task.isCompleted.toggle()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.plain)

            TextField("Task Description", text: $task.text, axis: .vertical)
                .focused(focusedTask, equals: task)
            Spacer()
        }
    }
}
