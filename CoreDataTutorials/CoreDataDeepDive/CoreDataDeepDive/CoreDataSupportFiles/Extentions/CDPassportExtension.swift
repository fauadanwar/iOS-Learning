//
//  CDPassportExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 01/12/23.
//

import Foundation

extension CDPassport: CDRecord {
    typealias T = Passport
    
    func convertToRecord() -> Passport {
        var employee: Employee?
        if let toEmployee {
            employee = Employee(_id: (toEmployee.id)!, _name: toEmployee.name!, _email:  toEmployee.email!, _profilePicture:  toEmployee.profilePicture!, _passport: nil, _vehicles: nil)
        }
        return Passport(_id: (self.id)!, _passportNumber: self.passportNumber, _placeOfIssue: self.placeOfIssue, _employee: employee)
    }
}
