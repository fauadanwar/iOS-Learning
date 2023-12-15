//
//  VehicleDataRepository.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 12/12/23.
//

import Foundation

protocol VehicleRepository : BaseDataRepository {
}

struct VehicleDataRepository : VehicleRepository
{
    typealias T = Vehicle
    typealias CDT = CDVehicle
    
    func assignProperties(record: Vehicle, cdRecord: CDVehicle) {
        cdRecord.name = record.name
        cdRecord.type = record.type
        cdRecord.number = record.number
        cdRecord.id = record.id
    }
    
    func updateProperties(record: Vehicle, cdRecord: CDVehicle) {
        cdRecord.name = record.name
        cdRecord.type = record.type
        cdRecord.number = record.number
    }
}
