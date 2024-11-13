//
//  NetworkMonitor.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 13.11.2024.
//

import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    @Published var isConnected: Bool = true
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    func checkConnectionOnce() {
        let temporaryMonitor = NWPathMonitor()
        temporaryMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                temporaryMonitor.cancel() 
            }
        }
        temporaryMonitor.start(queue: queue)
    }
}
