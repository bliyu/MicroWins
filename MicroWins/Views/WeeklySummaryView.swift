//
//  WeeklySummaryView.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Edited by:
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

import SwiftUI

struct WeeklySummaryView: View {
    @EnvironmentObject private var store: MicroWinsStore

    private var weeklyMessage: String {
        if store.thisWeekWins >= 5 {
            return "Amazing work this week. You stayed consistent and built strong momentum."
        } else if store.thisWeekWins >= 1 {
            return "Nice progress this week. Every small step matters."
        } else {
            return "A new week is a fresh chance to begin."
        }
    }

    private var badgeText: String {
        if store.thisWeekWins >= 7 {
            return "🏆 Goal Crusher"
        } else if store.thisWeekWins >= 5 {
            return "🔥 On Fire"
        } else if store.thisWeekWins >= 1 {
            return "✨ Building Momentum"
        } else {
            return "🌱 Fresh Start"
        }
    }

    var body: some View {
        ZStack {
            backgroundView

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    topCard

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

                    HStack(spacing: 14) {
                        statCard(
                            title: "Mood Entries",
                            value: "\(store.totalMoodEntries)",
                            icon: "heart.fill",
                            tint: .pink
                        )

                        statCard(
                            title: "Latest Mood",
                            value: store.latestMood,
                            icon: "face.smiling.fill",
                            tint: .white
                        )
                    }

                    badgeCard
                    reflectionCard
                    progressCard

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding()
                .padding(.bottom, 28)
            }
        }
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color.black,
                Color(red: 0.08, green: 0.01, blue: 0.06),
                Color(red: 0.18, green: 0.03, blue: 0.12)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    // MARK: TOP CARD
    private var topCard: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Weekly Summary 📈")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Track your growth and progress.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 58, height: 58)

                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .font(.title2)
                        .foregroundStyle(.pink)
                }
            }

            ProgressView(
                value: min(Double(store.thisWeekWins), 7),
                total: 7
            )
            .tint(.pink)

            Text("Weekly Goal: \(store.thisWeekWins) / 7 wins")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.75))
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [
                    Color.pink,
                    Color(red: 0.65, green: 0.10, blue: 0.35),
                    Color.black.opacity(0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.pink.opacity(0.35), lineWidth: 1)
        )
        .shadow(color: .pink.opacity(0.30), radius: 16, x: 0, y: 8)
    }

    // MARK: BADGE
    private var badgeCard: some View {
        HStack {
            Text("Achievement Badge")
                .foregroundStyle(.white)

            Spacer()

            Text(badgeText)
                .font(.headline)
                .foregroundStyle(.pink)
        }
        .padding()
        .cardStyle()
    }

    // MARK: REFLECTION
    private var reflectionCard: some View {
        HStack(alignment: .top, spacing: 12) {

            Image(systemName: "bolt.heart.fill")
                .foregroundStyle(.pink)

            VStack(alignment: .leading, spacing: 6) {
                Text("Weekly Reflection")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(weeklyMessage)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
            }

            Spacer()
        }
        .padding()
        .cardStyle()
    }

    // MARK: PROGRESS
    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 14) {

            Text("Progress Snapshot")
                .font(.headline)
                .foregroundStyle(.white)

            progressRow(
                title: "Wins This Week",
                value: store.thisWeekWins,
                total: 7
            )

            progressRow(
                title: "Mood Check-Ins",
                value: store.totalMoodEntries,
                total: max(store.totalMoodEntries, 7)
            )

            VStack(alignment: .leading, spacing: 6) {
                Text("Latest Mood")
                    .foregroundStyle(.white)

                Text(store.latestMood)
                    .font(.title3.bold())
                    .foregroundStyle(.pink)
            }
        }
        .padding()
        .cardStyle()
    }

    // MARK: STAT
    private func statCard(
        title: String,
        value: String,
        icon: String,
        tint: Color
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(tint.opacity(0.20))
                    .frame(width: 44, height: 44)

                Image(systemName: icon)
                    .foregroundStyle(tint)
            }

            Text(value)
                .font(.title.bold())
                .foregroundStyle(.white)

            Text(title)
                .foregroundStyle(.white)

            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 145)
        .padding()
        .cardStyle()
    }

    // MARK: PROGRESS ROW
    private func progressRow(
        title: String,
        value: Int,
        total: Int
    ) -> some View {

        VStack(alignment: .leading, spacing: 6) {

            HStack {
                Text(title)
                    .foregroundStyle(.white)

                Spacer()

                Text("\(value)")
                    .foregroundStyle(.white.opacity(0.6))
            }

            ProgressView(
                value: Double(value),
                total: Double(max(total, 1))
            )
            .tint(.pink)
        }
    }
}
