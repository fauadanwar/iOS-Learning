//
//  PassportDataRepository.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 04/12/23.
//

import Foundation
protocol PassportRepository : BaseDataRepository {
}

struct PassportDataRepository : PassportRepository
{
    typealias T = Passport
    typealias CDT = CDPassport
    
    func assignProperties(record: Passport, cdRecord: CDPassport) {
        cdRecord.placeOfIssue = record.placeOfIssue
        cdRecord.passportNumber = record.passportNumber
        cdRecord.id = record.id
    }
    
    func updateProperties(record: Passport, cdRecord: CDPassport) {
        cdRecord.placeOfIssue = record.placeOfIssue
        cdRecord.passportNumber = record.passportNumber
    }
}
