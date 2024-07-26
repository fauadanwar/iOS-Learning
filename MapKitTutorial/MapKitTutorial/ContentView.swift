//
//  ContentView.swift
//  MapKitTutorial
//
//  Created by Fouad Mohammed Rafique Anwar on 16/05/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    @State private var searchText: String = ""
    @State private var searchResults: [MKMapItem] = [MKMapItem]()
    @State private var selectedItem: MKMapItem?
    @State private var showDetails = false

    var body: some View {
        Map(position: $cameraPosition, selection: $selectedItem) {
            Annotation("Home", coordinate: .userLocation) {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .opacity(0.5)
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .opacity(1)
                    Image(systemName: "house")
                        .foregroundColor(.purple)
                }
            }
            
            ForEach(searchResults, id: \.self) { item in
                let placeMarker = item.placemark
                Marker(coordinate: placeMarker.coordinate) {
                    Image(systemName: "mappin")
                }
                .tint(.purple)

            }
        }
        .overlay(alignment: .top, content: {
            TextField("Search for a location..", text: $searchText)
                .font(.subheadline)
                .padding(12)
                .background(.white)
                .padding()
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        })
        .onChange(of: selectedItem, { oldValue, newValue in
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            LocationDetailView(selectedItem: $selectedItem, show: $showDetails)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        })
        .onSubmit(of: /*@START_MENU_TOKEN@*/.text/*@END_MENU_TOKEN@*/) {
            Task{
                 await searchPlace()
            }
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        
    }
}

extension ContentView {
    //Async Await Function and call in Task
    
    func searchPlace() async
    {
        do {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = searchText
            request.region = .userRegion
            let results = try await MKLocalSearch(request: request).start()
            self.searchResults = results.mapItems
        } catch  {
            print(error)
            self.searchResults = []
        }
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 18.496248, longitude: 73.870924)
    }
}

#Preview {
    ContentView()
}
