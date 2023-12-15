//
//  PassportListVCExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 04/12/23.
//

import Foundation
import UIKit

extension PassportListVC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.passport?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "passportListTC") as! PassportListTC
        let passport = self.passport![indexPath.row]

        cell.lblpassportNumber.text = passport.passportNumber
        cell.lblEmployeeName.text = passport.employee?.name
        return cell
    }
}
