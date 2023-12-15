//
//  DepartmentManager.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 15/12/23.
//

import Foundation
struct DepartmentManager {

    private let _departmentRepository : DepartmentDataRepository = DepartmentDataRepository()

    func create(record: Department)
    {
        _departmentRepository.create(record: record)
    }

    func getAllDepartments() -> [Department]?
    {
        return _departmentRepository.getAll()
    }

    func deleteDepartment(byIdentifier id: UUID) -> Bool
    {
        return _departmentRepository.delete(byIdentifier: id)
    }
}
