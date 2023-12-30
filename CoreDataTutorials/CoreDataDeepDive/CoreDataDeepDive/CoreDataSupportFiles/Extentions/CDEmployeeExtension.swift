//
//  CDEmployeeExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 01/12/23.
//

import Foundation

extension CDEmployee: CDRecord {
    typealias T = Employee
    
    func convertToRecord() -> Employee {
        
        var vehicles: [Vehicle]? = []
        
        if let toVehicles = self.toVehicles as? Set<CDVehicle>,
           toVehicles.count > 0
        {
            for toVehicle in toVehicles {
                vehicles?.append(Vehicle(_id: (toVehicle.id)!, _name: toVehicle.name, _type: toVehicle.type, _number: toVehicle.number, _employee: nil))
            }
        }
        
        var department: Department?
        if let toDepartment = self.toDepartment
        {
            department = Department(_id: toDepartment.id!, _name: toDepartment.name)
        }
        
        return Employee(_id: (self.id)!, _name: self.name!, _email: self.email!, _profilePicture: self.profilePicture!, _passport: self.toPassport?.convertToRecord(), _vehicles: vehicles, _department: department)
    }
}
