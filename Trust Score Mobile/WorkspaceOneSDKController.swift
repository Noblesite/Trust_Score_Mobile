//
//  WorkspaceOneSDKController..swift
//  Trust Score Mobile
//
//  Created by JONATHON POE on 4/14/25.
//

//
//  IntuneSDKController.swift
//  Trust Score Mobile
//
//  Created by JONATHON POE on 4/14/25.
//

struct WorkspaceOneSDKController {
    
    static func isCompliant() -> TrustSignal {
        return TrustSignal(name: "Device Compliant (Mock)", value: true, weight: 5)
    }
    
    static func isJailbroken() -> TrustSignal {
        return TrustSignal(name: "Jailbreak Detected (Mock)", value: false, weight: 5)
    }
    
    static func hasAppProtectionPolicy() -> TrustSignal {
        return TrustSignal(name: "App Protection Policy Applied (Mock)", value: true, weight: 4)
    }
    
    static func getAllSignals() -> [TrustSignal] {
        return [
            isCompliant(),
            isJailbroken(),
            hasAppProtectionPolicy()
        ]
    }
}
