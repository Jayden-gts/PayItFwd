//
//  SearchView.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
        let names = ["Yard Work", "Hair Cut", "Baby Sitting", "Nail Painting"]

    
    var body: some View {
        
        NavigationStack {
                    List {
                        ForEach(filteredNames, id: \.self) { name in
                            NavigationLink(destination: UserProfile()){
                                Text(name)
                            }
                        }
                    }
                    .navigationTitle("Search")
                    // The Search Bar
                    .searchable(text: $searchText, prompt: "Search items")
                }
            }
    var filteredNames: [String] {
            if searchText.isEmpty {
                return names
            } else {
                return names.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
}

#Preview {
    MainTabView()
}
