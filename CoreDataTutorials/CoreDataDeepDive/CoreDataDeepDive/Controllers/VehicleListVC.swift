//
//  VehicleListVC.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 12/12/23.
//

import UIKit

class VehicleListVC: UIViewController {

    var vehicles : [Vehicle]?
    private let vehicleManager: VehicleManager = VehicleManager()
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var tblVehicleList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vehicles"
        // Do any additional setup after loading the view.
        viewWillSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh(self)
    }
    
    func viewWillSetUp()
    {
        vehicles = vehicleManager.getAllVehicles()
        if(vehicles != nil && vehicles?.count != 0)
        {
            self.tblVehicleList.reloadData()
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tblVehicleList.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
        vehicles = vehicleManager.getAllVehicles()
        self.tblVehicleList.reloadData()
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
