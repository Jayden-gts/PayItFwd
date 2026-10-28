//
//  ConfirmCompletionView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-10-28.
//

import SwiftUI

struct ConfirmCompletionView: View {
    var workerName: String = "Jane"
    var proposedHours: Int = 3
    var hoursReported: Int = 3

    private var isOverLimit: Bool { hoursReported > proposedHours }

    var body: some View {
        VStack(spacing: 16) {
            Text("\(workerName) says the job is done")
            Image(systemName: "photo").font(.system(size: 80)).foregroundStyle(.white)
                .frame(maxWidth: .infinity).frame(height: 180).background(Color.gray)

            VStack(alignment: .leading, spacing: 8) {
                Text("Hours reported: \(hoursReported)")
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(Capsule().fill(Color.gray.opacity(0.2)))
                Text("Proposed: \(proposedHours)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if isOverLimit {
                    Label("\(hoursReported - proposedHours) hr over the proposed time",
                          systemImage: "exclamationmark.triangle.fill")
                        .font(.footnote)
                        .foregroundStyle(.orange)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()
            NavigationLink("Confirm",
                           destination: LeaveReviewView(workerName: workerName,
                                                        credits: hoursReported))
                .buttonStyle(.borderedProminent)
            Button("Report a problem") {}
                .buttonStyle(.bordered)
                .tint(isOverLimit ? .red : .accentColor)
        }
        .padding()
        .navigationTitle("Confirm completion")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { NavigationStack { ConfirmCompletionView(proposedHours: 3, hoursReported: 5) } }
