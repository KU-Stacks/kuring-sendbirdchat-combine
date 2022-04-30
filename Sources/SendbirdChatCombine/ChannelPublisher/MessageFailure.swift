//
//  MessageFailure.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import SendbirdChatSDK

public enum MessageFailure: Error {
    case generalFailure(SBError)
    case sendingFailed(BaseMessage, SBError)
}
