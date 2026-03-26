//
//  RootTabView.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Team edits:
//  - Add teammate names and edits here when needed.
//

import SwiftUI

struct RootTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        appearance.shadowColor = UIColor.systemPink.withAlphaComponent(0.18)

        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.65)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white.withAlphaComponent(0.65)
        ]

        appearance.stackedLayoutAppearance.selected.iconColor = .systemPink
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.systemPink
        ]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            NavigationStack {
                HomeDashboardView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                AddMicroWinView()
            }
            .tabItem {
                Label("Add Win", systemImage: "plus.circle.fill")
            }

            NavigationStack {
                MicroWinsListView()
            }
            .tabItem {
                Label("My Wins", systemImage: "checkmark.seal.fill")
            }

            NavigationStack {
                MoodCheckInView()
            }
            .tabItem {
                Label("Mood", systemImage: "heart.text.square.fill")
            }

            NavigationStack {
                WeeklySummaryView()
            }
            .tabItem {
                Label("Summary", systemImage: "chart.line.uptrend.xyaxis")
            }
        }
        .tint(.pink)
    }
}
