import SwiftUI

struct MicroWinsListView: View {
    @EnvironmentObject private var store: MicroWinsStore

    var body: some View {
        ZStack {
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

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    topCard

                    if store.microWins.isEmpty {
                        emptyStateCard
                    } else {
                        winsSection
                    }

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding()
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("My Wins")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - TOP CARD
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
                        .frame(width: 54, height: 54)

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
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: .pink.opacity(0.25), radius: 14, x: 0, y: 8)
    }

    // MARK: - EMPTY STATE
    private var emptyStateCard: some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 42))
                .foregroundStyle(.pink)

            Text("No MicroWins yet")
                .font(.headline)
                .foregroundStyle(.white)

            Text("Start adding small wins and they’ll appear here.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    // MARK: - WINS LIST
    private var winsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("All Wins")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                Text("\(store.microWins.count)")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            ForEach(store.microWins) { win in
                winCard(win)
            }
        }
    }

    // MARK: - WIN CARD
    private func winCard(_ win: MicroWin) -> some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.pink.opacity(0.25),
                                Color.white.opacity(0.08)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
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

                Text(win.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.55))
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    // MARK: - SUMMARY PILL
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
