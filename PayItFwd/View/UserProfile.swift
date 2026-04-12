//
//  UserProfile.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI


struct UserProfile: View {
    @EnvironmentObject var listingViewModel: ServiceListingViewModel

    private let currentUserId = "1"
    private let userName = "Jayden Seto"

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // Profile header
                VStack(spacing: 6) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 72, height: 72)
                        .foregroundStyle(Color(red: 50/255, green: 100/255, blue: 30/255))

                    Text(userName)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text("⭐️ 5.0 (100 reviews)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text("💚 1000 Credits")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top)

                Divider()

                // Listings header
                HStack {
                    Text("My Services")
                        .font(.headline)
                    Spacer()
                    Button {
                        listingViewModel.isShowingCreateSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color(red: 50/255, green: 100/255, blue: 30/255))
                    }
                }
                .padding(.horizontal)

                let userListings = listingViewModel.listingsForUser(userId: currentUserId)

                if userListings.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "tray")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("No listings yet. Tap + to add one.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 40)
                } else {
                    ForEach(userListings) { listing in
                        NavigationLink(destination: ServiceDetailView(listing: listing)) {
                            ServiceBubble(listing: listing)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $listingViewModel.isShowingCreateSheet) {
            CreateListingView(viewModel: listingViewModel)
        }
    }
}

#Preview {
    NavigationStack {
        UserProfile()
    }
    .environmentObject(ServiceListingViewModel())
}
