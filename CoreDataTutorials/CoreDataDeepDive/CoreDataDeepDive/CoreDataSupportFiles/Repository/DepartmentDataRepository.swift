//
//  DepartmentDataRepository.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 15/12/23.
//

import Foundation
protocol DepartmentRepository : BaseDataRepository {
}

struct DepartmentDataRepository : DepartmentRepository
{
    typealias T = Department
    typealias CDT = CDDepartment
    
    func assignProperties(record: Department, cdRecord: CDDepartment) {
        cdRecord.name = record.name
        cdRecord.id = record.id
    }
    
    func updateProperties(record: Department, cdRecord: CDDepartment) {
        cdRecord.name = record.name
    }
}
