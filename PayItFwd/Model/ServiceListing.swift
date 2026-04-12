//
//  ServiceListing.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-04-10.
//

import Foundation

struct ServiceReview: Identifiable {
    let id: UUID
    let reviewerName: String
    let rating: Int        // 1–5
    let comment: String
    let createdAt: Date

    init(id: UUID = UUID(), reviewerName: String, rating: Int, comment: String, createdAt: Date = Date()) {
        self.id = id
        self.reviewerName = reviewerName
        self.rating = max(1, min(5, rating))
        self.comment = comment
        self.createdAt = createdAt
    }
}

struct ServiceListing: Identifiable {
    let id: UUID
    var userId: String
    var title: String
    var description: String
    var category: ServiceCategory
    var createdAt: Date
    var reviews: [ServiceReview]

    var averageRating: Double? {
        guard !reviews.isEmpty else { return nil }
        return Double(reviews.map(\.rating).reduce(0, +)) / Double(reviews.count)
    }

    init(id: UUID = UUID(), userId: String, title: String, description: String,
         category: ServiceCategory, reviews: [ServiceReview] = []) {
        self.id = id
        self.userId = userId
        self.title = title
        self.description = description
        self.category = category
        self.createdAt = Date()
        self.reviews = reviews
    }
}

enum ServiceCategory: String, CaseIterable, Identifiable {
    case landscaping = "Landscaping"
    case haircutting = "Haircutting"
    case accounting  = "Accounting"
    case tutoring    = "Tutoring"
    case repairs     = "Repairs"
    case other       = "Other"

    var id: String { self.rawValue }
}
