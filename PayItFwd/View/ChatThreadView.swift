//
//  ChatThreadView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-10-28.
//

import SwiftUI

enum JobStatus {
    case none
    case inProgress(title: String, proposedHours: Int)
    
    case completed(title: String, proposedHours: Int, hoursReported: Int)
    case paid(title: String, credits: Int)
}

struct ChatThreadView: View {
    var name: String = "Jane Doe"
    var status: JobStatus = .inProgress(title: "Lawn makeover", proposedHours: 3)

    @State private var message = ""

    private let green = Color(red: 50/255, green: 100/255, blue: 30/255)

    var body: some View {
        VStack(spacing: 12) {
            banner

            ForEach(messages.indices, id: \.self) { i in
                bubble(messages[i].text, mine: messages[i].mine)
            }

            Spacer()
            TextField("Your message", text: $message).textFieldStyle(.roundedBorder)
        }
        .padding()
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
    }


    @ViewBuilder
    private var banner: some View {
        switch status {
        case .none:
            EmptyView()

        case .inProgress(let title, let proposedHours):
           
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.subheadline).bold()
                    Text("\(proposedHours) hrs")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                NavigationLink(destination: MarkCompleteView(proposedHours: proposedHours)) {
                    Text("Mark complete").font(.subheadline)
                }
                .buttonStyle(.borderedProminent)
                .tint(green)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))

        case .completed(let title, let proposedHours, let hoursReported):
        
            HStack {
                Image(systemName: "checkmark.seal.fill")
                    .font(.title2)
                    .foregroundStyle(green)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Job completed").font(.subheadline).bold()
                    Text(title)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                NavigationLink(destination: ConfirmCompletionView(
                    workerName: firstName,
                    proposedHours: proposedHours,
                    hoursReported: hoursReported)) {
                    Text("View & review").font(.subheadline)
                }
                .buttonStyle(.borderedProminent)
                .tint(green)
            }
            .padding()
            .background(green.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 10))

        case .paid(let title, let credits):
            // Worker side: credits received
            HStack {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundStyle(green)
                VStack(alignment: .leading, spacing: 2) {
                    Text("+\(credits) credits added").font(.subheadline).bold()
                    Text(title)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                NavigationLink(destination: CreditsEarnedView(transaction: .received,
                                                              otherName: firstName,
                                                              credits: credits)) {
                    Text("View").font(.subheadline)
                }
                .buttonStyle(.borderedProminent)
                .tint(green)
            }
            .padding()
            .background(green.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

  

    private var firstName: String {
        name.components(separatedBy: " ").first ?? name
    }

    private var messages: [(text: String, mine: Bool)] {
        switch status {
        case .completed:
            return [
                ("Hi! Can you help Friday?", true),
                ("Yes, 10am works", false),
                ("I'm done with the tasks!", false)
            ]
        default:
            return [
                ("Hi! Can you help Friday?", false),
                ("Yes, 10am works", true),
                ("Great, see you then", false)
            ]
        }
    }

    private func bubble(_ text: String, mine: Bool) -> some View {
        HStack {
            if mine { Spacer() }
            Text(text).padding(8)
                .background(mine ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                .cornerRadius(8)
            if !mine { Spacer() }
        }
    }
}

#Preview { NavigationStack { ChatThreadView() } }
