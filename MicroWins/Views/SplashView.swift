//
//  SplashView.swift
//  MicroWins
//
//  Author: Blen Abebe
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.black,
                    Color(red: 0.20, green: 0.00, blue: 0.10),
                    Color(red: 0.85, green: 0.25, blue: 0.55)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 110, height: 110)

                    Circle()
                        .stroke(Color.white.opacity(0.18), lineWidth: 1.5)
                        .frame(width: 124, height: 124)

                    Image(systemName: "sparkles")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white)
                }

                Text("MicroWins")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)

                Text("Celebrate small wins. Build real confidence.")
                    .font(.headline)
                    .foregroundStyle(Color.white.opacity(0.88))
                    .multilineTextAlignment(.center)

                VStack(spacing: 6) {
                    Text("Group 14")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text("Blen Abebe")
                    Text("Shalev Haimovitz")
                    Text("Jonathan Ivanov")
                    Text("Melica Alikhani-Marqueti")
                }
                .font(.subheadline)
                .foregroundStyle(Color.white.opacity(0.85))

                Spacer()

                VStack(spacing: 12) {
                    ProgressView()
                        .tint(.white)

                    Text("Loading your daily motivation...")
                        .font(.caption)
                        .foregroundStyle(Color.white.opacity(0.75))
                }
                .padding(.bottom, 28)
            }
            .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSplash = false
                }
            }
        }
    }
}
