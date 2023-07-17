//
//  CoreDataManager.swift
//  MovieListCoreData
//
//  Created by Fauad Anwar on 07/03/23.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core data failes to initialize \(error.localizedDescription)")
            }
        }
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func updateMovie()  {
        do {
            try persistentContainer.viewContext.save()

        } catch  {
            persistentContainer.viewContext.rollback()
            print("Failed to update movie \(error.localizedDescription)")
        }
    }
    
    func deleteMovie(movie: Movie)  {
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie deleted!")

        } catch  {
            persistentContainer.viewContext.rollback()
            print("Failed to delete movie \(error.localizedDescription)")
        }
    }
    
    func saveMovie(title: String)  {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie saved!")

        } catch  {
            print("Failed to save movie \(error.localizedDescription)")
        }
    }
}
