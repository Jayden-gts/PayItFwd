//
//  NavigationActions.swift
//  PayItFwd
//
//  Created by Laiba Ahmed on 2026-10-28.
//

import SwiftUI

private struct PopToInboxKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

private struct ShowLeaderboardKey: EnvironmentKey {
    static let defaultValue: () -> Void = {}
}

extension EnvironmentValues {
    var popToInbox: () -> Void {
        get { self[PopToInboxKey.self] }
        set { self[PopToInboxKey.self] = newValue }
    }

    var showLeaderboard: () -> Void {
        get { self[ShowLeaderboardKey.self] }
        set { self[ShowLeaderboardKey.self] = newValue }
    }
}
