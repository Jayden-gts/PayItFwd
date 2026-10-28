//
//  LeaveReviewView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-10-28.
//

import SwiftUI

struct LeaveReviewView: View {
    var workerName: String = "Jane"
    var credits: Int = 3
    @State private var rating = 3
    @State private var review = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("How was \(workerName)'s work?")
            HStack {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .font(.largeTitle).foregroundStyle(.yellow)
                        .onTapGesture { rating = star }
                }
            }
            TextField("Write a review...", text: $review, axis: .vertical)
                .lineLimit(5...8).textFieldStyle(.roundedBorder)

            Spacer()
            NavigationLink("Submit review",
                           destination: CreditsEarnedView(transaction: .given,
                                                          otherName: workerName,
                                                          credits: credits))
                .buttonStyle(.bordered)
        }
        .padding()
        .navigationTitle("Leave a review")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview { NavigationStack { LeaveReviewView() } }
