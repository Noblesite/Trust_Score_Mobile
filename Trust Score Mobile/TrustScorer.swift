import Foundation

class TrustScorer: ObservableObject {
    @Published var signals: [TrustSignal] = {
        let baseSignals = DeviceSignalManager.getAllSignals()
        switch AppConfigManager.mdmPlatform.lowercased() {
        case "intune":
            return baseSignals + IntuneSDKController.getAllSignals()
        case "ws1":
            return baseSignals + WorkspaceOneSDKController.getAllSignals() // future
        default:
            return baseSignals
        }
    }()

    var score: Int {
        let maxScore = signals.map { $0.weight }.reduce(0, +)
        let currentScore = signals.reduce(0) { $0 + ($1.value ? $1.weight : 0) }
        return Int((Double(currentScore) / Double(maxScore)) * 100)
    }
}
