//
//  ChartView.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//
import SwiftUI

struct ChartView: View {
    var body: some View {
        
        List{
            ForEach(1...6, id: \.self) { index in
                HStack {
                    NavigationLink(destination: UserProfile()) {
                        Text("\(index). User")
                        Spacer()
                        Text("x100")
                    }
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
