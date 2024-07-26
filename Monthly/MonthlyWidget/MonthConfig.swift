//
//  MonthConfig.swift
//  Monthly
//
//  Created by Fouad Mohammed Rafique Anwar on 25/07/24.
//

import Foundation
import SwiftUI

struct MonthConfig {
    let backgroundColor: Color
    let emojiText: String
    let weekdayTextColor: Color
    let dayTextColor: Color
    
    static let backgroundColor: [Color] = [
        .gray, .palePink, .paleGreen, .paleBlue,
        .paleYellow, .skyBlue, .blue, .paleOrange,
        .paleRed, .black, .paleBrown, .paleRed
    ]
    static let weekdayTextColor: [Color] = [
        .black.opacity(0.6), .black.opacity(0.5), .black.opacity(0.7), .black.opacity(0.5),
        .black.opacity(0.5), .black.opacity(0.5),  .black.opacity(0.5), .black.opacity(0.5),
        .black.opacity(0.5), .white.opacity(0.6), .black.opacity(0.6), .white.opacity(0.9)
    ]
    static let dayTextColor: [Color] = [
        .white.opacity(0.8), .pink.opacity(0.8), .darkGreen.opacity(0.8), .purple.opacity(0.8),
        .pink.opacity(0.7), .paleYellow.opacity(0.8), .paleBlue.opacity(0.8), .darkOrange.opacity(0.8),
        .paleYellow.opacity(0.9), .orange.opacity(0.8), .black.opacity(0.6), .darkGreen.opacity(0.7)
    ]
    
    static let monthEmojis = [
        "❄️", "⛅️", "🌤️", "🌞", "🏖️", "🌦️",
        "⛈️", "🌨️", "🌸", "🍃", "🍂", "💨"
    ]
    
    static func determineConfig(from date: Date) -> MonthConfig {
        let monthInt = Calendar.current.component(.month, from: date)
        return MonthConfig(backgroundColor: backgroundColor[monthInt],
                           emojiText: monthEmojis[monthInt],
                           weekdayTextColor: weekdayTextColor[monthInt],
                           dayTextColor: dayTextColor[monthInt])

    }
}
