//
//  EmployeeListTC.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 04/12/23.
//

import UIKit

class EmployeeListTC: UITableViewCell {

    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var imgEmployeeProfilePicture: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
