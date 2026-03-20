//
//  MainTabView.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI

struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            
            
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(
                red: 50/255,
                green: 100/255,
                blue: 30/255,
                alpha: 1.0
            )
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(
                    red: 50/255,
                    green: 100/255,
                    blue: 30/255,
                    alpha: 1.0
                )
            ]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        
        TabView {
            NavigationStack {
                HomeView()
                    .navigationTitle("Home")
            }
            .tabItem {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            }
            
            NavigationStack {
                ChartView()
                    .navigationTitle("Top Users")
            }
            .tabItem {
                VStack {
                    Image(systemName: "chart.bar.fill")
                    Text("Chart")
                }
            }
            
            NavigationStack {
                SearchView()
                    .navigationTitle("Search")
            }
            .tabItem {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            }
        }
        
        
        
    }
}
