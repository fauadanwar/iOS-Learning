//
//  VehicleManager.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 12/12/23.
//

import Foundation
struct VehicleManager {

    private let _vehicleRepository : VehicleDataRepository = VehicleDataRepository()

    func create(record: Vehicle)
    {
        _vehicleRepository.create(record: record)
    }

    func getAllVehicles() -> [Vehicle]?
    {
        return _vehicleRepository.getAll()
    }

    func deleteVehicle(byIdentifier id: UUID) -> Bool
    {
        return _vehicleRepository.delete(byIdentifier: id)
    }
}
