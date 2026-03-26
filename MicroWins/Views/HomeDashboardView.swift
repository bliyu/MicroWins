//
//  HomeDashboardView.swift
//  MicroWins
//
//  Author: Blen Abebe
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
            return "Good morning"
        case 12..<17:
            return "Good afternoon"
        case 17..<22:
            return "Good evening"
        default:
            return "Welcome back"
        }
    }

    private var motivationText: String {
        if store.totalWins == 0 {
            return "Start by recording one small win today. Tiny progress still matters."
        } else if store.thisWeekWins >= 5 {
            return "You are building amazing momentum this week. Keep going."
        } else if store.thisWeekWins >= 1 {
            return "You are making real progress. Every small win counts."
        } else {
            return "A fresh week is a fresh chance to grow. Add your next win."
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.10, green: 0.02, blue: 0.07),
                    Color(red: 0.18, green: 0.03, blue: 0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    heroSection

                    HStack(spacing: 14) {
                        statCard(
                            title: "Total Wins",
                            value: "\(store.totalWins)",
                            subtitle: "Your progress so far",
                            icon: "star.fill",
                            tint: .pink
                        )

                        statCard(
                            title: "This Week",
                            value: "\(store.thisWeekWins)",
                            subtitle: "Wins this week",
                            icon: "calendar",
                            tint: .white
                        )
                    }

                    moodInsightCard
                    motivationCard
                    quickActionsSection
                    recentWinsSection

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding()
                .padding(.bottom, 34)
            }
        }
        .navigationTitle("Dashboard")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 16) {
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
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 58, height: 58)

                    Image(systemName: "sparkles")
                        .font(.title2)
                        .foregroundStyle(.pink)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Track your progress, reflect on your mood, and celebrate the small wins that move you forward.")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.92))

                ProgressView(value: min(Double(store.thisWeekWins), 7), total: 7)
                    .tint(.pink)

                Text("Weekly goal: \(store.thisWeekWins) / 7 wins")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.78))
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
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .pink.opacity(0.22), radius: 16, x: 0, y: 8)
    }

    private var moodInsightCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.pink.opacity(0.14))
                    .frame(width: 58, height: 58)

                Image(systemName: "face.smiling.fill")
                    .font(.title2)
                    .foregroundStyle(.pink)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Latest Mood")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(store.latestMood)
                    .font(.title3.bold())
                    .foregroundStyle(.pink)

                Text("Tracking your feelings helps you notice patterns and growth.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.68))
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var motivationCard: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "bolt.heart.fill")
                .font(.title3)
                .foregroundStyle(.pink)
                .padding(.top, 2)

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
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.leading, 2)

            NavigationLink {
                AddMicroWinView()
            } label: {
                actionCard(
                    title: "Add MicroWin",
                    subtitle: "Record a small achievement from today",
                    icon: "plus.circle.fill",
                    tint: .pink
                )
            }

            NavigationLink {
                MicroWinsListView()
            } label: {
                actionCard(
                    title: "View My Wins",
                    subtitle: "Look back on your progress",
                    icon: "list.bullet.rectangle.fill",
                    tint: .white
                )
            }

            NavigationLink {
                MoodCheckInView()
            } label: {
                actionCard(
                    title: "Mood Check-In",
                    subtitle: "Save how you feel right now",
                    icon: "heart.text.square.fill",
                    tint: .pink
                )
            }

            NavigationLink {
                WeeklySummaryView()
            } label: {
                actionCard(
                    title: "Weekly Summary",
                    subtitle: "Review your weekly growth",
                    icon: "chart.bar.fill",
                    tint: .white
                )
            }
        }
    }

    private var recentWinsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("Recent MicroWins")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                Text("\(min(store.microWins.count, 3)) shown")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.62))
            }

            if store.microWins.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "sparkles.rectangle.stack")
                        .font(.largeTitle)
                        .foregroundStyle(.pink.opacity(0.85))

                    Text("No MicroWins yet")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text("Your recent achievements will appear here after you add them.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.68))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white.opacity(0.06), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 24))
            } else {
                ForEach(store.microWins.prefix(3)) { win in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.pink.opacity(0.22),
                                            Color.white.opacity(0.10)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
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

                            Text(win.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.55))
                        }

                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.white.opacity(0.06), lineWidth: 1)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                }
            }
        }
    }

    private func statCard(
        title: String,
        value: String,
        subtitle: String,
        icon: String,
        tint: Color
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(tint.opacity(0.16))
                        .frame(width: 44, height: 44)

                    Image(systemName: icon)
                        .foregroundStyle(tint)
                }

                Spacer()
            }

            Text(value)
                .font(.title.bold())
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.62))
            }
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
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
                    .frame(width: 54, height: 54)

                Image(systemName: icon)
                    .font(.title3)
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
                .foregroundStyle(.white.opacity(0.55))
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
