import SwiftUI

struct InfoFooterView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("MicroWins • Group 14")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 12)
    }
}
