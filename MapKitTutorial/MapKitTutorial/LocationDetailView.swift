//
//  LocationDetailView.swift
//  MapKitTutorial
//
//  Created by Fouad Mohammed Rafique Anwar on 16/05/24.
//

import SwiftUI
import MapKit
struct LocationDetailView: View {
    
    @Binding var selectedItem: MKMapItem?
    @Binding var show: Bool
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(selectedItem?.placemark.name ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(selectedItem?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                }
                Spacer()
                Button {
                    show.toggle()
                    selectedItem = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray))
                }
            }
        }
    }
}

#Preview {
    LocationDetailView(selectedItem: .constant(nil), show: .constant(true))
}

