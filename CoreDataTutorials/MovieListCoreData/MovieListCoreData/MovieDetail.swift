//
//  MovieDetail.swift
//  MovieListCoreData
//
//  Created by Fauad Anwar on 09/03/23.
//

import SwiftUI

struct MovieDetail: View {
    
    let movie: Movie
    @State private var movieTtitle: String = ""
    let coreDM: CoreDataManager
    @Binding var dataUpdated: Bool

    var body: some View {
        VStack {
            TextField(movie.title ?? "", text: $movieTtitle)
            Button("Update") {
                if !movieTtitle.isEmpty
                {
                    movie.title = movieTtitle
                    coreDM.updateMovie()
                    dataUpdated.toggle()
                }
            }
        }
        .padding()
    }
}

struct MovieDetail_Previews: PreviewProvider {
    
    static var previews: some View {
        let coreDM = CoreDataManager()
        let movie = Movie(context: coreDM.persistentContainer.viewContext)
        MovieDetail(movie: movie, coreDM: coreDM, dataUpdated: .constant(false))
    }
}
