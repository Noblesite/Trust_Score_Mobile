// ContentView.swift
import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var scorer = TrustScorer()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("📱 Trust Score")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("MDM: \(AppConfigManager.mdmPlatform.uppercased())")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("\(scorer.score)%")
                .font(.system(size: 48, weight: .heavy))
                .foregroundColor(scorer.score >= 80 ? .green : .orange)

            List(scorer.signals) { signal in
                HStack {
                    Text(signal.name)
                    Spacer()
                    Image(systemName: signal.value ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(signal.value ? .green : .red)
                }
            }
            .frame(height: 300)
        }
        .padding()
    }
}
