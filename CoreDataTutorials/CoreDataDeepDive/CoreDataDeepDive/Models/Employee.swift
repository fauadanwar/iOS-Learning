//
//  Employee.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import Foundation

class Employee: Record, Hashable 
{
    var id: UUID
    var name, email: String
    var profilePicture: Data
    var passport: Passport?
    var vehicles: [Vehicle]?
    var department: Department?

    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(_id: UUID, _name: String, _email: String, _profilePicture: Data, _passport: Passport? = nil, _vehicles: [Vehicle]? = nil, _department: Department? = nil) {

        self.id = _id
        self.name = _name
        self.email = _email
        self.profilePicture = _profilePicture
        self.passport = _passport
        self.vehicles = _vehicles
        self.department = _department
    }
}
