//
//  SplashView.swift
//  MicroWins
//
//  Author: Blen Abebe 
//  Edited by:
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
                    Color(red: 0.18, green: 0.02, blue: 0.10),
                    Color(red: 0.85, green: 0.25, blue: 0.55)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 22) {
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.10))
                        .frame(width: 118, height: 118)

                    Circle()
                        .stroke(Color.white.opacity(0.18), lineWidth: 1.5)
                        .frame(width: 134, height: 134)

                    Image(systemName: "sparkles")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundStyle(.white)
                }
                .shadow(color: .pink.opacity(0.28), radius: 16, x: 0, y: 8)

                VStack(spacing: 10) {
                    Text("MicroWins")
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)

                    Text("Celebrate small wins. Build real confidence.")
                        .font(.headline)
                        .foregroundStyle(Color.white.opacity(0.88))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 18)
                }

                VStack(spacing: 8) {
                    Text("Group 14")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text("Blen Abebe")
                    Text("Shalev Haimovitz")
                    Text("Jonathan Ivanov")
                    Text("Melica Alikhani-Marquet")
                }
                .font(.subheadline)
                .foregroundStyle(Color.white.opacity(0.85))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 12) {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.05)

                    Text("Loading your daily motivation...")
                        .font(.caption)
                        .foregroundStyle(Color.white.opacity(0.75))
                }
                .padding(.bottom, 28)
            }
            .padding()
        }
        .statusBarHidden()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showSplash = false
                }
            }
        }
    }
}
