//
//  DeviceSignalManager.swift
//  Trust Score Mobile
//
//  Created by JONATHON POE on 4/14/25.
//

import Foundation
import UIKit
import SystemConfiguration
import Network

struct DeviceSignalManager {
    
    static func getOSVersion() -> TrustSignal {
        let version = UIDevice.current.systemVersion
        let major = Int(version.split(separator: ".").first ?? "0") ?? 0
        return TrustSignal(name: "iOS Version >= 16", value: major >= 16, weight: 3)
    }
    
    static func getDeviceModelSignal() -> TrustSignal {
        let model = getDeviceModelIdentifier()
        let approvedModels = ["iPhone14,2", "iPhone14,3", "iPhone15,2", "iPhone15,3"] // Example whitelist
        return TrustSignal(name: "Approved Device Model", value: approvedModels.contains(model), weight: 2)
    }
    
    static func isAppManaged() -> TrustSignal {
        let managed = UserDefaults.standard.bool(forKey: "com.apple.configuration.managed")
        return TrustSignal(name: "MDM App Management", value: managed, weight: 4)
    }
    
    static func getNetworkType() -> TrustSignal {
        let monitor = NWPathMonitor()
        var isSecureNetwork = false
        let semaphore = DispatchSemaphore(value: 0)
        
        monitor.pathUpdateHandler = { path in
            if path.usesInterfaceType(.wifi) {
                isSecureNetwork = true
            }
            semaphore.signal()
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        _ = semaphore.wait(timeout: .now() + 1.0)
        monitor.cancel()
        
        return TrustSignal(name: "Secure Network (WiFi)", value: isSecureNetwork, weight: 1)
    }

    private static func getDeviceModelIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(cString: $0)
            }
        }
    }

    static func getAllSignals() -> [TrustSignal] {
        return [
            getOSVersion(),
            getDeviceModelSignal(),
            isAppManaged(),
            getNetworkType()
        ]
    }
}
