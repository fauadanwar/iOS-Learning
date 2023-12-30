//
//  EmployeeListVC.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import Foundation
import UIKit
import CoreData

extension EmployeeListVC : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeeDataProvider.fetchedResultController.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! EmployeeListTC
//        let employee = self.employees![indexPath.row]
        let employee = employeeDataProvider.fetchedResultController.object(at: indexPath).convertToRecord()
        cell.lblEmployeeName.text = employee.name
        cell.imgEmployeeProfilePicture.image = UIImage(data: employee.profilePicture)

        return cell
    }
}


extension EmployeeListVC : NSFetchedResultsControllerDelegate
{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tblEmployeeList.reloadData()
    }
}

