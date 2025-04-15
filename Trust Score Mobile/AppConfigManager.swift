//
//  AppConfigManager.swift
//  Trust Score Mobile
//
//  Created by JONATHON POE on 4/14/25.
//

import Foundation

struct AppConfigManager {
    static var mdmPlatform: String {
        UserDefaults.standard.string(forKey: "mdm_platform") ?? "intune" //TODO: setting InTune as defualt for protyping
    }
}
