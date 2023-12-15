//
//  PassportListVC.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 04/12/23.
//

import UIKit

class PassportListVC: UIViewController {

    var passport : [Passport]?
    private let passportManager: PassportManager = PassportManager()
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var tblPassportList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Passports"
        // Do any additional setup after loading the view.
        viewWillSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh(self)
    }
    
    func viewWillSetUp()
    {
        passport = passportManager.getAllPassports()
        if(passport != nil && passport?.count != 0)
        {
            self.tblPassportList.reloadData()
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tblPassportList.refreshControl = refreshControl
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        passport = passportManager.getAllPassports()
        self.tblPassportList.reloadData()
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
