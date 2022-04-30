//
//  ConnectionEvent.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation

public enum ConnectionEvent {
    case started
    case succeeded
    case failed
    case userConnected(String)
    case userDisconnected(String)
}
