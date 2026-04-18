//
//  AddMicroWinView.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Edited by:
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

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

    private let quickIdeas = [
        "Finished homework",
        "Went for a walk",
        "Cleaned my room",
        "Helped someone",
        "Learned something new"
    ]

    var body: some View {
        ZStack {
            backgroundView

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    topCard
                    inputCard
                    quickIdeasCard
                    tipsCard

                    if showMessage {
                        successCard
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }

                    saveButton

                    InfoFooterView()
                        .padding(.top, 8)
                }
                .padding()
                .padding(.bottom, 28)
            }
        }
        .navigationTitle("Add MicroWin")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 0.25), value: showMessage)
        .onChange(of: title) { _, _ in showMessage = false }
        .onChange(of: details) { _, _ in showMessage = false }
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
                    Text("Capture a Small Win ✨")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Tiny progress creates big results.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 56, height: 56)

                    Image(systemName: "sparkles")
                        .font(.title2)
                        .foregroundStyle(.pink)
                }
            }

            Text("Write down something positive you did today.")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.72))
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

    // MARK: INPUT CARD
    private var inputCard: some View {
        VStack(alignment: .leading, spacing: 18) {

            Text("New Entry")
                .font(.headline)
                .foregroundStyle(.white)

            VStack(alignment: .leading, spacing: 8) {
                Text("Title")
                    .foregroundStyle(.white.opacity(0.85))

                TextField("What went well today?", text: $title)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Details")
                    .foregroundStyle(.white.opacity(0.85))

                TextField(
                    "Add more details...",
                    text: $details,
                    axis: .vertical
                )
                .lineLimit(4...7)
                .foregroundStyle(.white)
                .padding()
                .background(Color.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding()
        .cardStyle()
    }

    // MARK: QUICK IDEAS
    private var quickIdeasCard: some View {
        VStack(alignment: .leading, spacing: 14) {

            Text("Quick Ideas")
                .font(.headline)
                .foregroundStyle(.white)

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 10
            ) {
                ForEach(quickIdeas, id: \.self) { idea in
                    Button {
                        title = idea
                    } label: {
                        Text(idea)
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.pink.opacity(0.18))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
            }
        }
        .padding()
        .cardStyle()
    }

    // MARK: TIPS
    private var tipsCard: some View {
        HStack(alignment: .top, spacing: 12) {

            Image(systemName: "lightbulb.fill")
                .foregroundStyle(.pink)

            Text("Even finishing one task counts as progress.")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))

            Spacer()
        }
        .padding()
        .cardStyle()
    }

    // MARK: SUCCESS
    private var successCard: some View {
        HStack(spacing: 12) {

            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.pink)

            VStack(alignment: .leading, spacing: 4) {
                Text("Saved Successfully")
                    .foregroundStyle(.white)

                Text("Your MicroWin was added.")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.72))
            }

            Spacer()
        }
        .padding()
        .cardStyle()
    }

    // MARK: BUTTON
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
                    .font(.headline)

                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
            .background(
                LinearGradient(
                    colors: isSaveDisabled
                    ? [
                        Color.gray.opacity(0.45),
                        Color.gray.opacity(0.30)
                    ]
                    : [
                        Color.pink,
                        Color(red: 0.80, green: 0.20, blue: 0.50)
                    ],
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
