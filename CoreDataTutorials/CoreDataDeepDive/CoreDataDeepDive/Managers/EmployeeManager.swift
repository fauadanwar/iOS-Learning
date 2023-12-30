//
//  EmployeeManager.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import Foundation
import CoreData

struct EmployeeManager
{
    private let _employeeRepository : EmployeeDataRepository = EmployeeDataRepository()

    func create(record: Employee)
    {
        if(validatePassport(passport: record.passport) == false)
        {
            record.passport = nil
        }
        if(validateDepartment(department: record.department) == false)
        {
            record.department = nil
        }
        _employeeRepository.create(record: record)
    }

    func getAllEmployee() -> [Employee]?
    {
        return _employeeRepository.getAll()
    }

    func deleteEmployee(byIdentifier id: UUID) -> Bool
    {
        return _employeeRepository.delete(byIdentifier: id)
    }

    func updateEmployee(record: Employee) -> Bool
    {
        return _employeeRepository.update(record: record)
    }

    private func validatePassport(passport: Passport?) -> Bool
    {
        if(passport == nil || passport?.passportNumber?.isEmpty == true || passport?.placeOfIssue?.isEmpty == true)
        {
            return false
        }

        return true
    }
    
    private func validateDepartment(department: Department?) -> Bool
    {
        if(department == nil || department?.name?.isEmpty == true)
        {
            return false
        }

        return true
    }
}

