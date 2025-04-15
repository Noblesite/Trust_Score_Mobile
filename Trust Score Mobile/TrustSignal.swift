// TrustSignal.swift
import Foundation

struct TrustSignal: Identifiable {
    let id = UUID()
    let name: String
    let value: Bool
    let weight: Int
}
