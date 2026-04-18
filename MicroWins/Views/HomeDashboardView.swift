//
//  HomeDashboardView.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Edited by:
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

import SwiftUI

struct HomeDashboardView: View {
    @EnvironmentObject private var store: MicroWinsStore

    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: Date())
    }

    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 5..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        case 17..<22:
            return "Good Evening"
        default:
            return "Welcome Back"
        }
    }

    private var motivationText: String {
        if store.totalWins == 0 {
            return "Start by recording one small win today."
        } else if store.thisWeekWins >= 5 {
            return "Amazing consistency this week. Keep it going."
        } else if store.thisWeekWins >= 1 {
            return "Small progress adds up every day."
        } else {
            return "A fresh week means a fresh start."
        }
    }

    private var streakText: String {
        "\(store.thisWeekWins) Day Streak"
    }

    var body: some View {
        ZStack {
            backgroundView

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    heroSection

                    HStack(spacing: 14) {
                        statCard(
                            title: "Total Wins",
                            value: "\(store.totalWins)",
                            icon: "star.fill",
                            tint: .pink
                        )

                        statCard(
                            title: "This Week",
                            value: "\(store.thisWeekWins)",
                            icon: "calendar",
                            tint: .white
                        )
                    }

                    moodCard
                    motivationCard
                    quickActionsSection
                    recentWinsSection

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding()
                .padding(.bottom, 28)
            }
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color.black,
                Color(red: 0.10, green: 0.02, blue: 0.08),
                Color(red: 0.18, green: 0.03, blue: 0.12)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 18) {

            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(greetingText) ✨")
                        .font(.title.bold())
                        .foregroundStyle(.white)

                    Text(dateText)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.82))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 60, height: 60)

                    Image(systemName: "sparkles")
                        .font(.title2)
                        .foregroundStyle(.pink)
                }
            }

            VStack(alignment: .leading, spacing: 10) {
                Text("Celebrate progress, track mood, and stay motivated.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))

                ProgressView(
                    value: min(Double(store.thisWeekWins), 7),
                    total: 7
                )
                .tint(.pink)

                HStack {
                    Text("Weekly Goal: \(store.thisWeekWins) / 7")
                    Spacer()
                    Text(streakText)
                }
                .font(.caption)
                .foregroundStyle(.white.opacity(0.75))
            }
        }
        .padding(22)
        .background(
            LinearGradient(
                colors: [
                    Color.black.opacity(0.92),
                    Color(red: 0.35, green: 0.05, blue: 0.20),
                    Color(red: 0.85, green: 0.25, blue: 0.55)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: .pink.opacity(0.22), radius: 16, x: 0, y: 8)
    }

    private var moodCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.pink.opacity(0.16))
                    .frame(width: 56, height: 56)

                Image(systemName: "heart.fill")
                    .foregroundStyle(.pink)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Latest Mood")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(store.latestMood)
                    .font(.title3.bold())
                    .foregroundStyle(.pink)

                Text("Track emotions and notice patterns.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.7))
            }

            Spacer()
        }
        .padding()
        .cardStyle()
    }

    private var motivationCard: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "bolt.heart.fill")
                .foregroundStyle(.pink)

            VStack(alignment: .leading, spacing: 6) {
                Text("Daily Motivation")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(motivationText)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.72))
            }

            Spacer()
        }
        .padding()
        .cardStyle()
    }

    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
                .foregroundStyle(.white)

            NavigationLink {
                AddMicroWinView()
            } label: {
                actionCard(
                    title: "Add MicroWin",
                    subtitle: "Save a small success",
                    icon: "plus.circle.fill",
                    tint: .pink
                )
            }

            NavigationLink {
                MicroWinsListView()
            } label: {
                actionCard(
                    title: "View Wins",
                    subtitle: "Review your progress",
                    icon: "list.bullet.rectangle.fill",
                    tint: .white
                )
            }

            NavigationLink {
                MoodCheckInView()
            } label: {
                actionCard(
                    title: "Mood Check-In",
                    subtitle: "How do you feel?",
                    icon: "heart.text.square.fill",
                    tint: .pink
                )
            }

            NavigationLink {
                WeeklySummaryView()
            } label: {
                actionCard(
                    title: "Weekly Summary",
                    subtitle: "Your growth this week",
                    icon: "chart.bar.fill",
                    tint: .white
                )
            }
        }
    }

    private var recentWinsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Recent Wins")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                Text("\(min(store.microWins.count, 3)) shown")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            if store.microWins.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "sparkles")
                        .font(.largeTitle)
                        .foregroundStyle(.pink)

                    Text("No wins yet")
                        .foregroundStyle(.white)

                    Text("Add your first MicroWin today.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 26)
                .cardStyle()

            } else {
                ForEach(store.microWins.prefix(3)) { win in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.pink.opacity(0.18))
                                .frame(width: 46, height: 46)

                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.pink)
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            Text(win.title)
                                .font(.headline)
                                .foregroundStyle(.white)

                            Text(win.details)
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.72))

                            Text(win.date.formatted(
                                date: .abbreviated,
                                time: .shortened
                            ))
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.55))
                        }

                        Spacer()
                    }
                    .padding()
                    .cardStyle()
                }
            }
        }
    }

    private func statCard(
        title: String,
        value: String,
        icon: String,
        tint: Color
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(tint.opacity(0.16))
                    .frame(width: 44, height: 44)

                Image(systemName: icon)
                    .foregroundStyle(tint)
            }

            Text(value)
                .font(.title.bold())
                .foregroundStyle(.white)

            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)

            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 145)
        .padding()
        .cardStyle()
    }

    private func actionCard(
        title: String,
        subtitle: String,
        icon: String,
        tint: Color
    ) -> some View {

        HStack(spacing: 14) {

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(tint.opacity(0.16))
                    .frame(width: 52, height: 52)

                Image(systemName: icon)
                    .foregroundStyle(tint)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.66))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundStyle(.white.opacity(0.5))
        }
        .padding()
        .cardStyle()
    }
}

extension View {
    func cardStyle() -> some View {
        self
            .background(Color.white.opacity(0.08))
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.white.opacity(0.06), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
