//
//  CreateListingView.swift
//  PayItFwd
//

import SwiftUI

struct CreateListingView: View {
    @ObservedObject var viewModel: ServiceListingViewModel

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedCategory: ServiceCategory = .other

    private let currentUserId = "1"

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Listing Details") {
                    TextField("Title", text: $title)

                    Picker("Category", selection: $selectedCategory) {
                        ForEach(ServiceCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }

                    ZStack(alignment: .topLeading) {
                        if description.isEmpty {
                            Text("Describe the service you're offering...")
                                .foregroundStyle(.secondary)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $description)
                            .frame(minHeight: 120)
                    }
                }

                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("New Listing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Post") {
                        viewModel.createListing(
                            userId: currentUserId,
                            title: title,
                            description: description,
                            category: selectedCategory
                        )
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}
