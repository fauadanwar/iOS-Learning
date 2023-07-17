//
//  ContentView.swift
//  MovieListCoreData
//
//  Created by Fauad Anwar on 07/03/23.
//

import SwiftUI

struct ContentView: View {
    
    let coreDM: CoreDataManager
    @State private var moveiName: String = ""
    @State private var movies: [Movie] = [Movie]()
    @State private var dataUpdated: Bool = false

    private func populateMovies() {
        movies = coreDM.getAllMovies()
    }
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter Movie Name", text: $moveiName)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    if !moveiName.isEmpty
                    {
                        coreDM.saveMovie(title: moveiName)
                        populateMovies()
                    }
                }
                List{
                    ForEach(movies, id: \.self) { movie in
                        NavigationLink {
                            MovieDetail(movie: movie, coreDM: coreDM, dataUpdated: $dataUpdated)
                        } label: {
                            Text(movie.title ?? "")
                        }
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let movie = movies[index]
                            coreDM.deleteMovie(movie: movie)
                            populateMovies()
                        }
                    }
                }
                .listStyle(.plain)
                .onChange(of: dataUpdated) { newValue in
                    populateMovies()
                }
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .onAppear {
                populateMovies()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
