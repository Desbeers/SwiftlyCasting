//
//  Model.swift
//  Cast
//
//  Created by Nick Berendsen on 16/12/2021.
//

import Foundation
import OpenCastSwift

class Caster: ObservableObject {
    @Published var scanner = CastDeviceScanner()
    
    @Published var client: CastClient?
    
    
    init() {
        
//        scanner = CastDeviceScanner()
//
//        client = CastClient(device: scanner.devices.first!)
//        client.connect()
        
        NotificationCenter.default.addObserver(forName: CastDeviceScanner.deviceListDidChange, object: scanner, queue: nil) { [unowned self] _ in
            print(self)
            //client = scanner.devices.first?.name ?? "No name"
            
            client = CastClient(device: scanner.devices.first!)
            client!.connect()
            
        }
        scanner.startScanning()
    }
}
