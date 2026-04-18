//
//  MicroWinsListView.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Edited by:
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

import SwiftUI

struct MicroWinsListView: View {
    @EnvironmentObject private var store: MicroWinsStore

    @State private var searchText = ""
    @State private var sortNewestFirst = true

    private var filteredWins: [MicroWin] {
        let searched = store.microWins.filter {
            searchText.isEmpty ||
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.details.localizedCaseInsensitiveContains(searchText)
        }

        return searched.sorted {
            sortNewestFirst ? $0.date > $1.date : $0.date < $1.date
        }
    }

    var body: some View {
        ZStack {
            backgroundView

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    topCard
                    searchCard

                    if filteredWins.isEmpty {
                        emptyStateCard
                    } else {
                        winsSection
                    }

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding()
                .padding(.bottom, 28)
            }
        }
        .navigationTitle("My Wins")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var backgroundView: some View {
        LinearGradient(
            colors: [
                Color.black,
                Color(red: 0.12, green: 0.02, blue: 0.08),
                Color(red: 0.18, green: 0.03, blue: 0.10)
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
                    Text("Your Progress ✨")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Every small win matters. Keep going.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 56, height: 56)

                    Image(systemName: "checkmark.seal.fill")
                        .font(.title2)
                        .foregroundStyle(.pink)
                }
            }

            HStack(spacing: 12) {
                summaryPill(title: "Total", value: "\(store.totalWins)")
                summaryPill(title: "This Week", value: "\(store.thisWeekWins)")
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [
                    Color.black.opacity(0.9),
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
        .shadow(color: .pink.opacity(0.25), radius: 14, x: 0, y: 8)
    }

    // MARK: SEARCH CARD
    private var searchCard: some View {
        VStack(spacing: 14) {

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.pink)

                TextField("Search wins...", text: $searchText)
                    .foregroundStyle(.white)
            }
            .padding()
            .background(Color.white.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Button {
                sortNewestFirst.toggle()
            } label: {
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                    Text(sortNewestFirst ? "Newest First" : "Oldest First")
                }
                .font(.subheadline.bold())
                .foregroundStyle(.white)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(Color.pink.opacity(0.18))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding()
        .cardStyle()
    }

    // MARK: EMPTY
    private var emptyStateCard: some View {
        VStack(spacing: 12) {

            Image(systemName: "sparkles")
                .font(.system(size: 42))
                .foregroundStyle(.pink)

            Text("No MicroWins Found")
                .font(.headline)
                .foregroundStyle(.white)

            Text("Try adding a new win or clearing search.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .cardStyle()
    }

    // MARK: LIST
    private var winsSection: some View {
        VStack(alignment: .leading, spacing: 14) {

            HStack {
                Text("All Wins")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                Text("\(filteredWins.count)")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            ForEach(filteredWins) { win in
                winCard(win)
            }
        }
    }

    // MARK: CARD
    private func winCard(_ win: MicroWin) -> some View {
        HStack(alignment: .top, spacing: 14) {

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.pink.opacity(0.20))
                    .frame(width: 52, height: 52)

                Image(systemName: "checkmark.seal.fill")
                    .foregroundStyle(.pink)
            }

            VStack(alignment: .leading, spacing: 8) {

                Text(win.title)
                    .font(.headline)
                    .foregroundStyle(.white)

                Text(win.details)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))

                Text(
                    win.date.formatted(
                        date: .abbreviated,
                        time: .shortened
                    )
                )
                .font(.caption)
                .foregroundStyle(.white.opacity(0.55))
            }

            Spacer()
        }
        .padding()
        .cardStyle()
    }

    // MARK: PILL
    private func summaryPill(title: String, value: String) -> some View {
        VStack(spacing: 4) {

            Text(value)
                .font(.headline)
                .foregroundStyle(.white)

            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
