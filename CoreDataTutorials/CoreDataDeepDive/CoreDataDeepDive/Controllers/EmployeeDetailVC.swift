//
//  ViewController.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import UIKit

class EmployeeDetailVC: UIViewController {
    
    private let manager = EmployeeManager()
    var selectedEmployee: Employee? = nil

    @IBOutlet weak var txtPassportPlaceOfIssue: UITextField!
    @IBOutlet weak var txtPassportNumber: UITextField!
    @IBOutlet weak var txtEmployeeEmail: UITextField!
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtDeaprtmentName: UITextField!
    @IBOutlet weak var imgEmployeeProfilePicture: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var vehicles : [Vehicle]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewWillSetUp()
    }

    func viewWillSetUp()
    {
        self.txtEmployeeName.text = selectedEmployee?.name
        self.txtEmployeeEmail.text = selectedEmployee?.email
        self.txtPassportNumber.text = selectedEmployee?.passport?.passportNumber
        self.txtPassportPlaceOfIssue.text = selectedEmployee?.passport?.placeOfIssue
        self.imgEmployeeProfilePicture.image = UIImage(data: (selectedEmployee?.profilePicture)!)
        self.txtDeaprtmentName.text = selectedEmployee?.department?.name
        self.vehicles = selectedEmployee?.vehicles
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        selectedEmployee?.name = self.txtEmployeeName.text!
        selectedEmployee?.email = self.txtEmployeeEmail.text!
        selectedEmployee?.passport?.passportNumber = self.txtPassportNumber.text!
        selectedEmployee?.passport?.placeOfIssue = self.txtPassportPlaceOfIssue.text
        selectedEmployee?.profilePicture = (self.imgEmployeeProfilePicture.image?.pngData())!
        selectedEmployee?.vehicles = self.vehicles
        selectedEmployee?.department?.name = self.txtDeaprtmentName.text!
        guard  manager.updateEmployee(record: selectedEmployee!) else {
            return
        }
        displayAlert(message: "Record Updated")

    }

    @IBAction func deleteButtonTapped(_ sender: Any) {

        if(manager.deleteEmployee(byIdentifier: selectedEmployee!.id))
        {
            displayAlert(message: "Employee record deleted")
        }else
        {
            debugPrint("Delete failed")
        }
    }

    @IBAction func addVehicleButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Vehicle", message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Type"
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Number"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self,
                  let nameTextField = alert.textFields?.first,
                  let typeTextField = alert.textFields?[1],
                  let numberTextField = alert.textFields?.last,
                  let name = nameTextField.text,
                  let type = typeTextField.text,
                  let number = numberTextField.text else {
                return
            }
            
            let newVehicle = Vehicle(_id: UUID(), _name: name, _type: type, _number: number)
            self.vehicles?.append(newVehicle)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }

    private func displayAlert(message: String)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
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
