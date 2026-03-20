//
//  ContentView.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            
        }
        
        VStack {
            ScrollView {
                Bubble()
                Bubble()
                Bubble()
            }
            .padding()
            
        }
        
        
    }
}

#Preview {
    HomeView()
}
