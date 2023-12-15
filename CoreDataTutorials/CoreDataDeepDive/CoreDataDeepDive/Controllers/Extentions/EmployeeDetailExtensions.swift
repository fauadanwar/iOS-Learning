//
//  DetailsVCExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import Foundation
import UIKit

extension EmployeeDetailVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[.originalImage] as? UIImage
        self.imgEmployeeProfilePicture.image = img

        dismiss(animated: true, completion: nil)
    }
}

extension EmployeeDetailVC: UITableViewDelegate, UITableViewDataSource
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

        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleTC") as! VehicleTC
        let vehicle = self.vehicles![indexPath.row]

        cell.lblVehicleNumber.text = vehicle.number
        cell.lblVehicleType.text = vehicle.type
        cell.lblVehicleName.text = vehicle.name
        return cell
    }
    
    // Slide to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vehicles?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
