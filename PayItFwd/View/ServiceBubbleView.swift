//
//  BubbleView.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI
import CoreData
import Foundation

struct ServiceBubble: View {
    var listing: ServiceListing? = nil

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.secondary.opacity(0.2))
                .frame(width: 350, height: 160)

            if let listing {
                VStack(alignment: .leading, spacing: 6) {
                    Text(listing.category.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(red: 50/255, green: 100/255, blue: 30/255))
                        .clipShape(Capsule())

                    Text(listing.title)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    Text(listing.description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                .padding(16)
            } else {
                Text("Service listing")
                    .foregroundStyle(.secondary)
                    .padding(16)
            }
        }
        .frame(width: 350, height: 160)
    }
}
    
