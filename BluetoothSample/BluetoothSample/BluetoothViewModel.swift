//
//  BluetoothViewModel.swift
//  BluetoothSample
//
//  Created by Fouad Mohammed Rafique Anwar on 31/07/24.
//

import UIKit
import Combine
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var paripheralNames: [String] = []
    private var connectedPeripheral: CBPeripheral?
    @Published var paripheralName: String?
    
    init(centralManager: CBCentralManager? = nil, paripheralNames: [String] = []) {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
        self.paripheralNames = paripheralNames
    }
    
    func startScanning() {
        self.centralManager?.scanForPeripherals(withServices: nil)
    }
    
    func stopScanning() {
        self.centralManager?.stopScan()
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("Bluetooth is On")
            self.centralManager?.scanForPeripherals(withServices: nil)
        case .poweredOff:
            print("Bluetooth is Off")
        case .resetting:
            print("Bluetooth is Resetting")
        case .unauthorized:
            print("Bluetooth is Unauthorized")
        case .unknown:
            print("Bluetooth is Unknown")
        case .unsupported:
            print("Bluetooth is Unsupported")
        @unknown default:
            print("Unknown state")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            peripherals.append(peripheral)
            paripheralNames.append(peripheral.name ?? "Unknown")
//            central.connect(peripheral, options: nil)
        }
    }
}

extension BluetoothViewModel: CBPeripheralDelegate {
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown")")
        connectedPeripheral = peripheral
        paripheralName = peripheral.name
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        print("Failed to connect to \(peripheral.name ?? "Unknown")")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        print("Disconnected from \(peripheral.name ?? "Unknown")")
        connectedPeripheral = nil
        paripheralName = nil
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)?) {
        if let services = peripheral.services {
            for service in services {
                print("Discovered service: \(service)")
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: (any Error)?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                print("Discovered characteristic: \(characteristic)")
                if characteristic.properties.contains(.read) {
                    peripheral.readValue(for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        if let value = characteristic.value {
            print("Value: \(value)")
        }
    }
}
