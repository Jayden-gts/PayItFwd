//
//  UserProfile.swift
//  PayItFwd
//
//  Created by Jayden Seto on 2026-03-19.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("User Name User Last Name")
                Text("5 Stars (100)")
                Text("Credits x1000")
                ServiceBubble()
                Text("lorem")
            }
            .padding()
        }
    }
}

#Preview {
    UserProfile()
}
