//
//  Vehicle.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 06/12/23.
//

import UIKit

class Vehicle: Record, Hashable {
    
    var id: UUID
    var name, type, number: String?
    let employee: Employee?
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(_id: UUID, _name: String?, _type: String?, _number: String?, _employee: Employee? = nil)
    {
        self.id = _id
        self.name = _name
        self.type = _type
        self.number = _number
        self.employee = _employee
    }
}
