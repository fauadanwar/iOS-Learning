//
//  Passport.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 01/12/23.
//

import Foundation

class Passport: Record
{
    var id: UUID
    var passportNumber, placeOfIssue: String?
    let employee: Employee?

    init(_id: UUID, _passportNumber: String?, _placeOfIssue: String?, _employee: Employee? = nil)
    {
        self.id = _id
        self.placeOfIssue = _placeOfIssue
        self.passportNumber = _passportNumber
        self.employee = _employee
    }
}
