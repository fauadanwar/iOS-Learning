//
//  CDDepartmentExtension.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 15/12/23.
//

import Foundation

extension CDDepartment: CDRecord {
    typealias T = Department
    
    func convertToRecord() -> Department {
        var employees: [Employee]? = []
        
        if let toEmployees = self.toEmployees as? Set<Employee>,
           toEmployees.count > 0
        {
            for toEmployee in toEmployees {
                employees?.append(Employee(_id: (toEmployee.id), _name: toEmployee.name, _email:  toEmployee.email, _profilePicture:  toEmployee.profilePicture, _passport: nil, _vehicles: nil))
            }
        }
        return Department(_id: (self.id)!, _name: self.name, _employees: employees)
    }
}
