//
//  ServiceListingRepository.swift
//  PayItFwd
//

import Foundation

class ServiceListingRepository {
    static let shared = ServiceListingRepository()

    private(set) var listings: [ServiceListing] = []

    private init() {
        seedData()
    }

    // MARK: - Seed

    private func seedData() {
        let hardcodedReviews: [ServiceReview] = [
            ServiceReview(
                reviewerName: "Maria Chen",
                rating: 5,
                comment: "Jayden did an incredible job with my front yard. Very professional and thorough — highly recommend!",
                createdAt: Date().addingTimeInterval(-86400 * 10)
            ),
            ServiceReview(
                reviewerName: "Alex Thompson",
                rating: 4,
                comment: "Great work overall. Showed up on time and cleaned up after. Would exchange again.",
                createdAt: Date().addingTimeInterval(-86400 * 5)
            ),
            ServiceReview(
                reviewerName: "Priya Nair",
                rating: 5,
                comment: "Super friendly and did way more than expected. My garden looks amazing.",
                createdAt: Date().addingTimeInterval(-86400 * 2)
            )
        ]

        let seededListing = ServiceListing(
            userId: "1",
            title: "Lawn & Garden Maintenance",
            description: "I offer lawn mowing, hedge trimming, weeding, and general garden cleanup. Happy to work out an exchange — looking for accounting or tutoring services in return.",
            category: .landscaping,
            reviews: hardcodedReviews
        )

        listings.append(seededListing)
    }

    // MARK: - CRUD

    func save(_ listing: ServiceListing) {
        listings.append(listing)
    }

    func getAll() -> [ServiceListing] {
        return listings
    }

    func getListings(forUserId userId: String) -> [ServiceListing] {
        return listings.filter { $0.userId == userId }
    }
}
