//
//  PassportManager.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 04/12/23.
//

import Foundation

struct PassportManager {

    private let _passportRepository : PassportDataRepository = PassportDataRepository()

    func create(record: Passport)
    {
        _passportRepository.create(record: record)
    }

    func getAllPassports() -> [Passport]?
    {
        return _passportRepository.getAll()
    }

    func deletePassports(byIdentifier id: UUID) -> Bool
    {
        return _passportRepository.delete(byIdentifier: id)
    }
}
