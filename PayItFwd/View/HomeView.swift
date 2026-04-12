//
//  HomeView.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var listingViewModel: ServiceListingViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if listingViewModel.listings.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "rectangle.stack")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        Text("No listings yet.")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("Go to your profile to add one.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 80)
                } else {
                    ForEach(listingViewModel.listings) { listing in
                        NavigationLink(destination: UserProfile()) {
                            ServiceBubble(listing: listing)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .navigationTitle("Home")
    }
    .environmentObject(ServiceListingViewModel())
}
