//
//  CoreDataManager.swift
//  CoreDataMDA
//
//  Created by Fauad Anwar on 22/06/23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataMDA")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core data failes to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func getAllEvent() -> [Event] {
        let fetchRequest: NSFetchRequest<Event> = Event.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func getAllLocation() -> [Location] {
        if let fetchLocations: NSFetchRequest = persistentContainer.managedObjectModel.fetchRequestTemplate(forName: "FetchAllLocation")
        {
            do {
                return try persistentContainer.viewContext.fetch(fetchLocations) as! [Location]
            } catch {
                return []
            }
        }
        else
        {
            return []
        }
    }
    
    func saveContext()  {
        do {
            try persistentContainer.viewContext.save()
            
        } catch  {
            persistentContainer.viewContext.rollback()
            print("Failed to update Event \(error.localizedDescription)")
        }
    }
    
    func deleteEvent(event: Event)  {
        persistentContainer.viewContext.delete(event)
        
        do {
            try persistentContainer.viewContext.save()
            print("Event deleted!")
            
        } catch  {
            persistentContainer.viewContext.rollback()
            print("Failed to delete Event \(error.localizedDescription)")
        }
    }
    
    func deleteLocation(location: Location)  {
        persistentContainer.viewContext.delete(location)
        
        do {
            try persistentContainer.viewContext.save()
            print("Location deleted!")
            
        } catch  {
            persistentContainer.viewContext.rollback()
            print("Failed to delete Location \(error.localizedDescription)")
        }
    }
    
    func createLocation(address: String, imageName: String) -> Location? {
        let location = Location(context: persistentContainer.viewContext)
        location.address = address
        location.image = UIImage(named: imageName)
        do {
            try persistentContainer.viewContext.save()
            print("Location saved!")
            return location
        } catch  {
            print("Failed to save Location \(error.localizedDescription)")
            return nil
        }
    }
    
    func createEvent(eventDate: Date, cost: Double, address: String, imageName: String) -> Event?
    {
        let location = createLocation(address: address, imageName: imageName)
        
        let event = Event(context: persistentContainer.viewContext)
        event.eventDate = eventDate
        event.cost = cost
        event.location = location

        do {
            try persistentContainer.viewContext.save()
            print("Event saved!")
            return event
            
        } catch  {
            print("Failed to save Event \(error.localizedDescription)")
            return nil
        }
    }
}
