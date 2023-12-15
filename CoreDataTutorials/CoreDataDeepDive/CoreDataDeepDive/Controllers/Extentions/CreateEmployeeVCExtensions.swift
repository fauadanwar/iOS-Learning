//
//  EmployeeListCell.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import UIKit

class EmployeeListCell: UITableViewCell {

    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var lblEmployeeName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
