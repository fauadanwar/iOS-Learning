//
//  EmployeeListVC.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import UIKit

class EmployeeListVC: UIViewController {

    @IBOutlet weak var tblEmployeeList: UITableView!

    var employees : [Employee]? = nil
    private var manager = EmployeeManager()
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Employees"
        // Do any additional setup after loading the view.
        viewWillSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh(self)
    }
    
    func viewWillSetUp() {
        self.employees = manager.getAllEmployee()
        if(employees != nil && employees?.count != 0)
        {
            self.tblEmployeeList.reloadData()
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tblEmployeeList.refreshControl = refreshControl
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        self.employees = manager.getAllEmployee()
        self.tblEmployeeList.reloadData()
        self.refreshControl.endRefreshing()
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == SegueIdentifier.navigateToDetailView)
        {
            let employeeDetailView = segue.destination as? EmployeeDetailVC
            guard employeeDetailView != nil else { return }
            employeeDetailView?.selectedEmployee = self.employees![self.tblEmployeeList.indexPathForSelectedRow!.row]
        }
    }
}
