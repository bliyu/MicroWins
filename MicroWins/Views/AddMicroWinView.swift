import SwiftUI

struct AddMicroWinView: View {
    @EnvironmentObject private var store: MicroWinsStore

    @State private var title = ""
    @State private var details = ""
    @State private var showMessage = false

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var isSaveDisabled: Bool {
        trimmedTitle.isEmpty
    }

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
                    inputCard
                    tipsCard

                    if showMessage {
                        successCard
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }

                    saveButton

                    InfoFooterView()
                        .padding(.top, 6)
                }
                .padding()
                .padding(.bottom, 30)
            }
        }
        .navigationTitle("Add MicroWin")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 0.25), value: showMessage)
        .onChange(of: title) { _, _ in showMessage = false }
        .onChange(of: details) { _, _ in showMessage = false }
    }

    // MARK: - TOP CARD
    private var topCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Capture a small win ✨")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Small progress builds big results.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 54, height: 54)

                    Image(systemName: "sparkles")
                        .font(.title2)
                        .foregroundStyle(.pink)
                }
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

    // MARK: - INPUT CARD
    private var inputCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("New MicroWin")
                .font(.headline)
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 8) {
                Text("Title")
                    .foregroundStyle(.white.opacity(0.85))

                TextField("What went well today?", text: $title)
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Details")
                    .foregroundStyle(.white.opacity(0.85))

                TextField("Add a little more detail...", text: $details, axis: .vertical)
                    .lineLimit(4...7)
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white.opacity(0.06), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    // MARK: - TIPS
    private var tipsCard: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "lightbulb.fill")
                .foregroundStyle(.pink)

            Text("Even finishing a small task counts as a win. Progress is built daily.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: - SUCCESS
    private var successCard: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.pink)

            Text("Saved successfully")
                .foregroundStyle(.white)

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    // MARK: - BUTTON
    private var saveButton: some View {
        Button {
            store.addMicroWin(title: title, details: details)
            title = ""
            details = ""
            showMessage = true
        } label: {
            HStack {
                Spacer()

                Label("Save MicroWin", systemImage: "plus.circle.fill")

                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
            .background(
                LinearGradient(
                    colors: isSaveDisabled
                        ? [Color.gray.opacity(0.4), Color.gray.opacity(0.3)]
                        : [Color.pink, Color(red: 0.80, green: 0.20, blue: 0.50)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .pink.opacity(0.25), radius: 10, x: 0, y: 6)
        }
        .disabled(isSaveDisabled)
    }
}
