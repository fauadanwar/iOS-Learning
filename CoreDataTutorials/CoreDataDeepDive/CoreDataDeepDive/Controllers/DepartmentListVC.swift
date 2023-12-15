//
//  DepartmentListVC.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 15/12/23.
//

import UIKit

class DepartmentListVC: UIViewController {
    var departments : [Department]?
    private let departmentManager: DepartmentManager = DepartmentManager()
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var tblDepartmentList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Departments"
        // Do any additional setup after loading the view.
        viewWillSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh(self)
    }
    
    func viewWillSetUp()
    {
        departments = departmentManager.getAllDepartments()
        if(departments != nil && departments?.count != 0)
        {
            self.tblDepartmentList.reloadData()
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tblDepartmentList.refreshControl = refreshControl
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        departments = departmentManager.getAllDepartments()
        self.tblDepartmentList.reloadData()
        self.refreshControl.endRefreshing()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
