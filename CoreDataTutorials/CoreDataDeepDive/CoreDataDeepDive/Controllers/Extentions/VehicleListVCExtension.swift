//
//  VehicleListVCExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 12/12/23.
//

import Foundation
import UIKit

extension VehicleListVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.vehicles?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleListTC") as! VehicleListTC
        let vehicle = self.vehicles![indexPath.row]

        cell.lblVehicleNumber.text = vehicle.number
        cell.lblEmployeeName.text = vehicle.employee?.name
        return cell
    }
}
