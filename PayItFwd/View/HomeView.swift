//
//  ContentView.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView {
                    NavigationLink(destination: UserProfile()) {
                                        ServiceBubble()
                                    }
                    NavigationLink(destination: UserProfile()) {
                                        ServiceBubble()
                                    }
                    NavigationLink(destination: UserProfile()) {
                                        ServiceBubble()
                                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
