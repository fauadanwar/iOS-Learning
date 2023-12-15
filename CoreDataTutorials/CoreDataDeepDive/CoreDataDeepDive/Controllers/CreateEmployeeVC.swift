//
//  CreateEmployeeVCViewController.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import UIKit

class CreateEmployeeVC: UIViewController {

    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var imgEmployeePicture: UIImageView!
    @IBOutlet weak var txtEmployeeEmail: UITextField!
    @IBOutlet weak var txtPlaceOfIssue: UITextField!
    @IBOutlet weak var txtPassportNumber: UITextField!
    @IBOutlet weak var txtDeaprtmentName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var vehicles : [Vehicle]? = []

    private var placeOfIssuePicker: UIPickerView!

    private let manager = EmployeeManager()
    let places = ["Bangalore", "Delhi","Indore", "Jaipur","Mumbai", "Pune"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewWillSetUp()
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(documentDirectoryPath[0])
    }

    func viewWillSetUp()
    {
        self.title = "Add Employee"

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.dismissPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        placeOfIssuePicker = UIPickerView()
        placeOfIssuePicker.dataSource = self
        placeOfIssuePicker.delegate = self
        
        self.txtPlaceOfIssue.inputView = placeOfIssuePicker
        self.txtPlaceOfIssue.inputAccessoryView = toolBar
        
        tableView.tableFooterView = UIView()
    }

    @objc func dismissPicker() {
        self.view.endEditing(true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {

        let passport = Passport(_id: UUID(), _passportNumber: self.txtPassportNumber.text, _placeOfIssue: self.txtPlaceOfIssue.text)

        let department = Department(_id: UUID(), _name: self.txtDeaprtmentName.text)

        let employee = Employee(_id: UUID(), _name: self.txtEmployeeName.text!, _email: self.txtEmployeeEmail.text!, _profilePicture: (self.imgEmployeePicture.image?.pngData())!, _passport: passport, _vehicles: vehicles, _department: department)
        
        manager.create(record: employee)
        displayAlert(alertMessage: "Record Saved")
    }

    @IBAction func clearAllButtonTapped(_ sender: Any) {
        self.txtEmployeeName.text = nil
        self.txtEmployeeEmail.text = nil
        self.txtPassportNumber.text = nil
        self.txtPlaceOfIssue.text = nil
        self.txtDeaprtmentName.text = nil
        vehicles = []
        tableView.tableFooterView = UIView()
    }

    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
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
    
    private func displayAlert(alertMessage: String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
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
