//
//  InfoFooterView.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Edited by:
//  Shalev Haimovitz
//  Jonathan Ivanov
//  Melica Alikhani-Marquet
//

import SwiftUI

struct InfoFooterView: View {
    var body: some View {
        VStack(spacing: 6) {
            Divider()
                .overlay(Color.white.opacity(0.08))

            Text("MicroWins • Group 14")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.65))

            Text("Celebrate progress one step at a time.")
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.45))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
        .padding(.bottom, 6)
    }
}
