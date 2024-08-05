//
//  ContentView.swift
//  BluetoothSample
//
//  Created by Fouad Mohammed Rafique Anwar on 31/07/24.
//

import SwiftUI
import CoreBluetooth

struct BluetoothView: View {
    
    @ObservedObject private var viewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.paripheralNames, id: \.self) { name in
                Text(name)
            }
            .navigationTitle("Bluetooth Devices")
        }
    }
}

#Preview {
    BluetoothView()
}
