//
//  Department.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 15/12/23.
//

import Foundation
class Department: Record, Hashable {
    
    var id: UUID
    var name: String?
    let employees: [Employee]?
    
    static func == (lhs: Department, rhs: Department) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(_id: UUID, _name: String?, _employees: [Employee]? = nil)
    {
        self.id = _id
        self.name = _name
        self.employees = _employees
    }
}
