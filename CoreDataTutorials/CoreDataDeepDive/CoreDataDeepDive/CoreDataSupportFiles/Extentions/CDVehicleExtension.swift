//
//  CDVehicleExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 12/12/23.
//

import Foundation

extension CDVehicle: CDRecord {
    typealias T = Vehicle
    
    func convertToRecord() -> Vehicle {
        var employee: Employee?
        if let toEmployee {
            employee = Employee(_id: (toEmployee.id)!, _name: toEmployee.name!, _email:  toEmployee.email!, _profilePicture:  toEmployee.profilePicture!, _passport: nil, _vehicles: nil)
        }
        return Vehicle(_id: (self.id)!, _name: self.name, _type: self.type, _number: self.number, _employee: employee)
    }
}
