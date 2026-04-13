//
//  PayItFwdApp.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI

@main
struct PayItFwdApp: App {
    @StateObject private var listingViewModel = ServiceListingViewModel()

    var body: some Scene {
        WindowGroup {
                LoginView()
            .environmentObject(listingViewModel)        }
    }
}
