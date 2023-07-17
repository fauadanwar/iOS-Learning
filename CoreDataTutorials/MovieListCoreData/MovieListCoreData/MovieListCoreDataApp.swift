//
//  MovieListCoreDataApp.swift
//  MovieListCoreData
//
//  Created by Fauad Anwar on 07/03/23.
//

import SwiftUI

@main
struct MovieListCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coreDM: CoreDataManager())
        }
    }
}
