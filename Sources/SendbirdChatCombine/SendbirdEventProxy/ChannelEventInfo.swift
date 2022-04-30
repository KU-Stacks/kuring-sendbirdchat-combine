//
//  ChannelEventInfo.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import SendbirdChatSDK

public struct ChannelEventInfo: Equatable {
    let channel: BaseChannel
    let event: ChannelEvent
}
