//
//  Date+Extensions.swift
//  UIDocument_PhotoKeeper
//
//  Created by Fauad Anwar on 24/03/23.
//

import Foundation

private var mediumFormatter: DateFormatter = {
    let dateFormatter =  DateFormatter()
    dateFormatter.doesRelativeDateFormatting = true
    dateFormatter.timeStyle = .medium
    dateFormatter.dateStyle = .medium
    return dateFormatter
}()

extension Date {
  var mediumString: String {
    return mediumFormatter.string(from: self)
  }
}
