//
//  ServiceListingViewModel.swift
//  PayItFwd
//

import Foundation
import Combine

class ServiceListingViewModel: ObservableObject {
    @Published var listings: [ServiceListing] = []
    @Published var isShowingCreateSheet: Bool = false
    @Published var errorMessage: String? = nil

    private let repository = ServiceListingRepository.shared

    init() {
        fetchAll()
    }

    func fetchAll() {
        listings = repository.getAll()
    }

    func createListing(userId: String, title: String, description: String, category: ServiceCategory) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Title cannot be empty."
            return
        }
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Description cannot be empty."
            return
        }

        let newListing = ServiceListing(
            userId: userId,
            title: title,
            description: description,
            category: category
        )

        repository.save(newListing)
        fetchAll()
        isShowingCreateSheet = false
        errorMessage = nil
    }

    func listingsForUser(userId: String) -> [ServiceListing] {
        listings.filter { $0.userId == userId }
    }
}
