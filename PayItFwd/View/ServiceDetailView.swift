//
//  ServiceDetailView.swift
//  PayItFwd
//

import SwiftUI

struct ServiceDetailView: View {
    let listing: ServiceListing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Category badge + title
                VStack(alignment: .leading, spacing: 8) {
                    Text(listing.category.rawValue)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color(red: 50/255, green: 100/255, blue: 30/255))
                        .clipShape(Capsule())

                    Text(listing.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(listing.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                Divider()

                // Rating summary
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rating")
                        .font(.headline)

                    if let avg = listing.averageRating {
                        HStack(spacing: 6) {
                            StarRatingView(rating: avg)
                            Text(String(format: "%.1f", avg))
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("(\(listing.reviews.count) review\(listing.reviews.count == 1 ? "" : "s"))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    } else {
                        Text("No ratings yet.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Divider()

                // Reviews
                VStack(alignment: .leading, spacing: 16) {
                    Text("Reviews")
                        .font(.headline)

                    if listing.reviews.isEmpty {
                        VStack(spacing: 8) {
                            Image(systemName: "bubble.left")
                                .font(.largeTitle)
                                .foregroundStyle(.secondary)
                            Text("No reviews yet.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)
                    } else {
                        ForEach(listing.reviews) { review in
                            ReviewCard(review: review)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Service Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Star Rating View

struct StarRatingView: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: starImageName(for: star))
                    .foregroundStyle(Color.yellow)
                    .font(.subheadline)
            }
        }
    }

    private func starImageName(for star: Int) -> String {
        let value = rating - Double(star - 1)
        if value >= 1 { return "star.fill" }
        if value >= 0.5 { return "star.leadinghalf.filled" }
        return "star"
    }
}

// MARK: - Review Card

struct ReviewCard: View {
    let review: ServiceReview

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(review.reviewerName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(review.createdAt.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            StarRatingView(rating: Double(review.rating))

            Text(review.comment)
                .font(.subheadline)
                .foregroundStyle(.primary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        ServiceDetailView(listing: ServiceListing(
            userId: "1",
            title: "Lawn & Garden Maintenance",
            description: "Sample description for preview.",
            category: .landscaping,
            reviews: [
                ServiceReview(reviewerName: "Alice", rating: 5, comment: "Great service!"),
                ServiceReview(reviewerName: "Bob", rating: 4, comment: "Very good.")
            ]
        ))
    }
}
