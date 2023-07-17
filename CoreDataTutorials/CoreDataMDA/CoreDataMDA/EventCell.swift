//
//  EventCell.swift
//  CoreDataMDA
//
//  Created by Fauad Anwar on 23/06/23.
//

import Foundation
import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    func configureCell(event: Event) {
        dateLabel.text = event.eventDate?.asFormattedString()
        costLabel.text = "\(event.cost.twoDecimalString())"
        addressLabel.text = event.location?.address
    }
}

extension Double{
    func twoDecimalString() -> String
    {
        return String(format: "%.2f", self)
    }
}

extension Date {
    func asFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY, MMM d, hh:mm"
        return formatter.string(from: self)
    }
}

