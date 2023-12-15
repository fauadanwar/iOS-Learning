//
//  DepartmentListVCExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 15/12/23.
//

import Foundation
import UIKit

extension DepartmentListVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.departments?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "departmentListTC") as! DepartmentListTC
        let department = self.departments![indexPath.row]

        cell.lblDepartmentName.text = department.name
        return cell
    }
}
