//
//  MonthlyWidget.swift
//  MonthlyWidget
//
//  Created by Fouad Mohammed Rafique Anwar on 13/04/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DayEntry {
        DayEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (DayEntry) -> ()) {
        let entry = DayEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [DayEntry] = []

        // Generate a timeline consisting of seven entries a day apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startOfDay = Calendar.current.startOfDay(for: entryDate)
            let entry = DayEntry(date: startOfDay)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct DayEntry: TimelineEntry {
    let date: Date
}

struct MonthlyWidgetEntryView : View {
    var entry: DayEntry
    var config: MonthConfig
    
    init(entry: DayEntry) {
        self.entry = entry
        self.config = MonthConfig.determineConfig(from: entry.date)
    }
    
    var body: some View {
        ZStack {
            if #unavailable(iOS 17.0) {
                ContainerRelativeShape()
                    .fill(.blue.gradient)
            }
            VStack {
                HStack(spacing: 4) {
                    Text(config.emojiText)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(entry.date.dayOfWeek)
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .minimumScaleFactor(0.6)
                        .foregroundColor(config.weekdayTextColor)
                }
                Text(entry.date.dateNumber)
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                    .foregroundColor(config.dayTextColor)
            }
        }
    }
}

//wrire extention on date to return date name
extension Date {
    var dayOfWeek: String {
        self.formatted(.dateTime.weekday(.wide))
    }
    var dateNumber: String {
        self.formatted(.dateTime.day())
    }
    static func dateToDisplay(month: Int, day: Int) -> Date {
        let component = DateComponents(calendar: .current, year: 2022, month: month, day: day)
        return Calendar.current.date(from: component)!
    }
}

struct MonthlyWidget: Widget {
    let kind: String = "MonthlyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                let config = MonthConfig.determineConfig(from: entry.date)

                MonthlyWidgetEntryView(entry: entry)
                    .containerBackground(config.backgroundColor, for: .widget)
            } else {
                MonthlyWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("Monthly Style Widget")
        .description("This theme of the widget changes based on the month.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    MonthlyWidget()
} timeline: {
    DayEntry(date: Date.dateToDisplay(month: 1, day: 21))
    DayEntry(date: Date.dateToDisplay(month: 2, day: 22))
    DayEntry(date: Date.dateToDisplay(month: 3, day: 23))
    DayEntry(date: Date.dateToDisplay(month: 4, day: 24))
}

