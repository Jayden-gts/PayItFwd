//
//  InboxView.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-10-28.
//

import SwiftUI

struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let lastMessage: String
    var unread: Bool
    let status: JobStatus
}

struct InboxView: View {
    @State private var searchText = ""
    @State private var path = NavigationPath()   // clearing this pops back to the Inbox
    
    @State private var chats = [
        Chat(name: "Jane Doe", lastMessage: "I'm done with the tasks!", unread: true,
             status: .completed(title: "Lawn makeover", proposedHours: 3, hoursReported: 4)),
        Chat(name: "Carol H.", lastMessage: "Thanks for the help...", unread: false,
             status: .paid(title: "Garden cleanup", credits: 3)),
        Chat(name: "Charli X.", lastMessage: "Can you do 3 hours?", unread: true,
             status: .inProgress(title: "Hair cut", proposedHours: 3)),
        Chat(name: "Org A", lastMessage: "Volunteer day Oct 11", unread: false,
             status: .none)
    ]
    
    private var filteredChats: [Chat] {
        searchText.isEmpty
        ? chats
        : chats.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.lastMessage.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private func setUnread(_ chat: Chat, to value: Bool) {
        if let i = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[i].unread = value
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            List(filteredChats) { chat in
                NavigationLink(value: chat.id) {
                    HStack {
                        Image(systemName: "person.circle").font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(chat.name).bold()
                            Text(chat.lastMessage).font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        if chat.unread {
                            Circle().fill(.blue).frame(width: 12, height: 12)
                        }
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        setUnread(chat, to: !chat.unread)
                    } label: {
                        Label(chat.unread ? "Read" : "Unread",
                              systemImage: chat.unread ? "envelope.open" : "envelope.badge")
                    }
                    .tint(.blue)
                }
            }
            .navigationTitle("Messages")
            .searchable(text: $searchText, prompt: "Search messages")
            .navigationDestination(for: UUID.self) { id in
                if let chat = chats.first(where: { $0.id == id }) {
                    ChatThreadView(name: chat.name, status: chat.status)
                        .onAppear { setUnread(chat, to: false) }
                }
            }
        }
        .environment(\.popToInbox, { path = NavigationPath() })   
    }
    
}

#Preview { InboxView() }
