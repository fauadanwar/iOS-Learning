//
//  EmployeeDataRepository.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import Foundation
import CoreData

protocol EmployeeRepository {

    func create(employee: Employee)
    func getAll() -> [Employee]?
    func get(byIdentifier id: UUID) -> Employee?
    func update(employee: Employee) -> Bool
    func delete(id: UUID) -> Bool
}

struct EmployeeDataRepository : EmployeeRepository
{
    func create(employee: Employee) {

        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.email = employee.email
        cdEmployee.name = employee.name
        cdEmployee.id = employee.id
        cdEmployee.profilePicture = employee.profilePicture

        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [Employee]? {

        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDEmployee.self)

        var employees : [Employee] = []

        result?.forEach({ (cdEmployee) in
            employees.append(cdEmployee.convertToEmployee())
        })

        return employees
    }

    func get(byIdentifier id: UUID) -> Employee? {

        let result = getCDEmployee(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToEmployee()
    }

    func update(employee: Employee) -> Bool {
        guard let cdEmployee = getCDEmployee(byIdentifier: employee.id) else {return false}
        cdEmployee.email = employee.email
        cdEmployee.name = employee.name
        cdEmployee.profilePicture = employee.profilePicture
        PersistentStorage.shared.saveContext()
        return true
    }

    func delete(id: UUID) -> Bool {
        guard let cdEmployee = getCDEmployee(byIdentifier: id) else {return false}
        PersistentStorage.shared.context.delete(cdEmployee)
        PersistentStorage.shared.saveContext()
        return true
    }


    private func getCDEmployee(byIdentifier id: UUID) -> CDEmployee?
    {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            guard let result = try PersistentStorage.shared.context.fetch(fetchRequest).first else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }

        return nil
    }

}
