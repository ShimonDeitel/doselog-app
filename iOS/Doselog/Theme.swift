import SwiftUI

/// Bespoke palette for Doselog. Not shared with other apps in the portfolio.
enum Theme {
    static let background = Color(red: 0.055, green: 0.082, blue: 0.098)
    static let surface = Color(red: 0.086, green: 0.125, blue: 0.149)
    static let accent = Color(red: 0.227, green: 0.486, blue: 0.647)
    static let textPrimary = Color(red: 0.902, green: 0.937, blue: 0.953)
    static let textMuted = Color(red: 0.498, green: 0.627, blue: 0.710)

    static let titleFont: Font = .system(.title2, design: .rounded).weight(.bold)
    static let headlineFont: Font = .system(.headline, design: .rounded)
    static let bodyFont: Font = .system(.body, design: .rounded)
    static let captionFont: Font = .system(.caption, design: .rounded)

    static let cornerRadius: CGFloat = 16
}
