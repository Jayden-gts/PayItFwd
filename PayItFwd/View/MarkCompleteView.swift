//
//  MarkCompleteView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-10-28.
//

import SwiftUI

struct MarkCompleteView: View {
    let proposedHours: Int
    @State private var hoursWorked: Int
    @State private var showSubmitted = false
    @Environment(\.dismiss) private var dismiss

    private let green = Color(red: 50/255, green: 100/255, blue: 30/255)

    // Starts the picker at the hours agreed on in the chat
    init(proposedHours: Int = 3) {
        self.proposedHours = proposedHours
        _hoursWorked = State(initialValue: proposedHours)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Photo of finished work")
            VStack {
                Image(systemName: "photo").font(.system(size: 70)).foregroundStyle(.gray)
                Text("Take photo")
            }
            .frame(maxWidth: .infinity).frame(height: 180)
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray))

            Text("Hours worked")
            HStack {
                Picker("Hours worked", selection: $hoursWorked) {
                    ForEach(1...12, id: \.self) { hour in
                        Text("\(hour) hour\(hour == 1 ? "" : "s")").tag(hour)
                    }
                }
                .pickerStyle(.menu)
                .tint(green)
                .padding(.horizontal, 8)
                .background(Capsule().fill(Color.gray.opacity(0.2)))

                Text("Proposed: \(proposedHours) hrs")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if hoursWorked > proposedHours {
                Label("This is over the proposed time. The other person will be able to review it.",
                      systemImage: "exclamationmark.triangle.fill")
                    .font(.footnote)
                    .foregroundStyle(.orange)
            }

            Spacer()
            Button {
                showSubmitted = true
            } label: {
                Text("Submit for confirmation")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(green)
        }
        .padding()
        .navigationTitle("Mark complete")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Submitted!", isPresented: $showSubmitted) {
            Button("OK") { dismiss() }
        } message: {
            Text("\(hoursWorked) hour\(hoursWorked == 1 ? "" : "s") sent for confirmation. You'll be notified once they review it.")
        }
    }
}

#Preview { NavigationStack { MarkCompleteView() } }
