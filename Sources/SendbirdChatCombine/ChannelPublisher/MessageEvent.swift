//
//  MessageEvent.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import SendbirdChatSDK

public enum MessageEvent: Equatable {
    case tempMessage(BaseMessage)
    case sentMessage(BaseMessage)
    case progress(Int64, Int64, Int64)
}
