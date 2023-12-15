//
//  BaseRepository.swift
//  CoreDataDeepDive
//
//  Created by fanwar on 04/12/23.
//

import Foundation
import CoreData

protocol BaseDataRepository {

    associatedtype CDT where CDT: NSFetchRequestResult, CDT: NSManagedObject, CDT: CDRecord
    associatedtype T where T: BaseModel
    
    func create(record: T)
    func getAll() -> [T]?
    func get(byIdentifier id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(byIdentifier id: UUID) -> Bool
    func assignProperties(record: T, cdRecord: CDT)
    func updateProperties(record: T, cdRecord: CDT)
}

extension BaseDataRepository {
    
    func create(record: T) {
        let cdRecord = CDT(context: PersistentStorage.shared.context)
        assignProperties(record: record, cdRecord: cdRecord)
        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [CDT.T]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDT.self)
        var records : [CDT.T] = []
        result?.forEach({ (cdRecord) in
            records.append(cdRecord.convertToRecord())
        })
        return records
    }

    func get(byIdentifier id: UUID) -> CDT.T? {
        guard let result = getCDRecord(byIdentifier: id) else {return nil}
        return result.convertToRecord()
    }
    
    func update(record: T) -> Bool {
        guard let cdRecord = getCDRecord(byIdentifier: record.id) else {return false}
        updateProperties(record: record, cdRecord: cdRecord)
        PersistentStorage.shared.saveContext()
        return true
    }

    func delete(byIdentifier id: UUID) -> Bool {
        guard let cdRecord = getCDRecord(byIdentifier: id) else {return false}
        PersistentStorage.shared.context.delete(cdRecord)
        PersistentStorage.shared.saveContext()
        return true
    }


    private func getCDRecord(byIdentifier id: UUID) -> CDT?
    {
        let fetchRequest = NSFetchRequest<CDT>(entityName: String(describing: CDT.self))
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
