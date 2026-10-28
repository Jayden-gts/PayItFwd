//
//  CreditsEarnedView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-10-28.
//

import SwiftUI

enum CreditTransaction {
    case given      // I received the service, so I paid credits
    case received   // I did the work, so I got credits
}

struct CreditsEarnedView: View {
    var transaction: CreditTransaction = .given
    var otherName: String = "Jane"
    var credits: Int = 3
    var balanceBefore: Int = 10   // hardcoded until real user data

    @Environment(\.popToInbox) private var popToInbox
    @Environment(\.showLeaderboard) private var showLeaderboard

    private let green = Color(red: 50/255, green: 100/255, blue: 30/255)

    private var newBalance: Int { balanceBefore + credits }

    private var creditWord: String { credits == 1 ? "credit" : "credits" }

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: transaction == .given ? "checkmark.circle.fill" : "plus.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(green)

            switch transaction {
            case .given:
                Text("\(credits) \(creditWord) given to \(otherName)")
                    .font(.title2).bold()
                    .multilineTextAlignment(.center)
                Text("Thanks for confirming!")
                    .foregroundStyle(.secondary)
            case .received:
                Text("+\(credits) \(creditWord) added")
                    .font(.title).bold()
                Text("Received from \(otherName)")
                    .foregroundStyle(.secondary)
                Text("New balance: \(newBalance) credits")
                    .font(.headline)
            }

            Spacer()
            Button("View leaderboard") {
                showLeaderboard()   // switch to the Chart tab
                popToInbox()        // reset Messages so it's at the Inbox when they come back
            }
            .buttonStyle(.bordered)

            Button("Back to messages") { popToInbox() }
                .buttonStyle(.borderedProminent)
                .tint(green)
        }
        .padding()
        .navigationTitle("Exchange complete")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview { NavigationStack { CreditsEarnedView() } }
#Preview("Received") { NavigationStack { CreditsEarnedView(transaction: .received) } }
