//
//  NetworkStatus.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//


import Network

class NetworkStatus {

    static let shared = NetworkStatus()
    let monitor: NWPathMonitor?

    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        let queue = DispatchQueue(label: "NetworkStatus")
        monitor?.start(queue: queue)
    }
}

