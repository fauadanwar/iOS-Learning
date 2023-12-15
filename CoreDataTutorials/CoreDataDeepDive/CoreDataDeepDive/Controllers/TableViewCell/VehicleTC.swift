//
//  VehicleTC.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 12/12/23.
//

import UIKit

class VehicleTC: UITableViewCell {

    @IBOutlet weak var lblVehicleNumber: UILabel!
    @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var lblVehicleType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
