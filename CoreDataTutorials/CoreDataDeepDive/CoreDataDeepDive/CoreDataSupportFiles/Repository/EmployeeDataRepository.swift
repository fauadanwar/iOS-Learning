//
//  EmployeeDataRepository.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 30/11/23.
//

import Foundation
import CoreData

protocol EmployeeRepository : BaseDataRepository {
}

struct EmployeeDataRepository : EmployeeRepository
{
    typealias T = Employee
    typealias CDT = CDEmployee
    
    func assignProperties(record: Employee, cdRecord: CDEmployee) {
        cdRecord.id = record.id
        cdRecord.email = record.email
        cdRecord.name = record.name
        cdRecord.profilePicture = record.profilePicture
       
        if let department = record.department
        {
            let cdDepartment = CDDepartment(context: PersistentStorage.shared.context)
            cdDepartment.name = record.department?.name
            cdRecord.toDepartment = cdDepartment
        }
        if let passport = record.passport
        {
            let cdPassport = CDPassport(context: PersistentStorage.shared.context)
            cdPassport.placeOfIssue = passport.placeOfIssue
            cdPassport.passportNumber = passport.passportNumber
            cdPassport.id = passport.id
            
            cdPassport.toEmployee = cdRecord
            
            cdRecord.toPassport = cdPassport
        }
        
        if let vehicles = record.vehicles,
            vehicles.count > 0
        {
            var vehiclesSet: Set<CDVehicle> = []
            for vehicle in vehicles {
                let cdVehicle = CDVehicle(context: PersistentStorage.shared.context)
                cdVehicle.name = vehicle.name
                cdVehicle.type = vehicle.type
                cdVehicle.number = vehicle.number
                cdVehicle.id = vehicle.id

                cdVehicle.toEmployee = cdRecord

                vehiclesSet.insert(cdVehicle)
            }
            cdRecord.toVehicles = vehiclesSet as NSSet
        }
    }
    
    func updateProperties(record: Employee, cdRecord: CDEmployee) {
        cdRecord.email = record.email
        cdRecord.name = record.name
        cdRecord.profilePicture = record.profilePicture

        cdRecord.toPassport?.placeOfIssue = record.passport?.placeOfIssue
        cdRecord.toPassport?.passportNumber = record.passport?.passportNumber
        cdRecord.toDepartment?.name = record.department?.name

        if let department = record.department,
           let toDepartment = cdRecord.toDepartment
        {
            toDepartment.name = department.name
        }
        else if let department = record.department
        {
            let cdDepartment = CDDepartment(context: PersistentStorage.shared.context)
            cdDepartment.name = record.department?.name
            cdRecord.toDepartment = cdDepartment
        }
        
        if let vehicles = record.vehicles,
           vehicles.count > 0
        {
            var vehiclesSet: Set<CDVehicle> = []
                        
            if let toVehicles = cdRecord.toVehicles as? Set<CDVehicle>,
               toVehicles.count > 0
            {
                let removedRecords = toVehicles.filter { cdv in
                    !vehicles.contains(where: { $0.id == cdv.id })
                }
                let vehicleManager = VehicleManager()
                for toVehicle in removedRecords {
                    _ = vehicleManager.deleteVehicle(byIdentifier: toVehicle.id!)
                }
                
                let exisitingRecords = toVehicles.filter { cdv in
                    vehicles.contains(where: { $0.id == cdv.id })
                }
                vehiclesSet = exisitingRecords
                
                let newRecords = vehicles.filter { v in
                    !toVehicles.contains(where: { $0.id != v.id })
                }
                for vehicle in newRecords {
                    let cdVehicle = CDVehicle(context: PersistentStorage.shared.context)
                    cdVehicle.name = vehicle.name
                    cdVehicle.type = vehicle.type
                    cdVehicle.number = vehicle.number
                    cdVehicle.id = vehicle.id
                    
                    vehiclesSet.insert(cdVehicle)
                }
            }
            else
            {
                for vehicle in vehicles {
                    let cdVehicle = CDVehicle(context: PersistentStorage.shared.context)
                    cdVehicle.name = vehicle.name
                    cdVehicle.type = vehicle.type
                    cdVehicle.number = vehicle.number
                    cdVehicle.id = vehicle.id

                    vehiclesSet.insert(cdVehicle)
                }
            }
            cdRecord.toVehicles = vehiclesSet as NSSet
        }
        else
        {
            if let toVehicles = cdRecord.toVehicles as? Set<CDVehicle>,
               toVehicles.count > 0
            {
                let vehicleManager = VehicleManager()
                for toVehicle in toVehicles {
                    _ = vehicleManager.deleteVehicle(byIdentifier: toVehicle.id!)
                }
            }
            cdRecord.toVehicles = nil
        }
    }
}
