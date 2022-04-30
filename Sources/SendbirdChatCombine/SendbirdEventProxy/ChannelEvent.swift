//
//  ChannelEvent.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

public enum ChannelEvent {
    case received(BaseMessage)
    case updated(BaseMessage)
    case messageDeleted(Int64)
    case receivedMention(BaseMessage)
    case userEntered(User)
    case userExited(User)
    case userMuted(User)
    case userUnmuted(User)
    case userBanned(User)
    case userUnbanned(User)
    case changed
}
