//
//  SendbirdDelegateProxy.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

class SendbirdDelegateProxy: NSObject {
    static let shared = SendbirdDelegateProxy()
    static var channelDelegateID = "delegate.channel"
    static var connectionlDelegateID = "delegate.connection"
    
    let channelPassthrough: PassthroughSubject<ChannelEventInfo, Never>
    let connectionPassthrough: PassthroughSubject<ConnectionEvent, Never>
    
    deinit {
        SendbirdChat.removeAllChannelDelegates()
        SendbirdChat.removeAllConnectionDelegates()
    }
    
    override init() {
        channelPassthrough = .init()
        connectionPassthrough = .init()
        
        super.init()
        
        SendbirdChat.add(self as BaseChannelDelegate, identifier: SendbirdDelegateProxy.channelDelegateID)
        SendbirdChat.add(self as ConnectionDelegate, identifier: SendbirdDelegateProxy.connectionlDelegateID)
    }
}

// MARK: Open Channel Delegate
extension SendbirdDelegateProxy: OpenChannelDelegate {
    // MARK: Message updates
    func channel(_ channel: BaseChannel, didReceive message: BaseMessage) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .received(message)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: BaseChannel, didUpdate message: BaseMessage) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .updated(message)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: BaseChannel, messageWasDeleted messageId: Int64) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .messageDeleted(messageId)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: BaseChannel, didReceiveMention message: BaseMessage) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .receivedMention(message)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    // MARK: User updates
    func channel(_ channel: OpenChannel, userDidEnter user: User) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .userEntered(user)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: OpenChannel, userDidExit user: User) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .userExited(user)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: BaseChannel, userWasMuted user: User) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .userMuted(user)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: BaseChannel, userWasUnmuted user: User) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .userUnmuted(user)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: BaseChannel, userWasBanned user: User) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .userBanned(user)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    func channel(_ channel: BaseChannel, userWasUnbanned user: User) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .userUnbanned(user)
        )
        channelPassthrough.send(channelEventInfo)
    }
    
    // MARK: Channel updates
    func channelWasChanged(_ channel: BaseChannel) {
        let channelEventInfo = ChannelEventInfo(
            channel: channel,
            event: .changed
        )
        channelPassthrough.send(channelEventInfo)
    }
}

// MARK: Connection delegate
extension SendbirdDelegateProxy: ConnectionDelegate {
    func didStartReconnection() {
        connectionPassthrough.send(.started)
    }
    
    func didSucceedReconnection() {
        connectionPassthrough.send(.succeeded)
    }
    
    func didFailReconnection() {
        connectionPassthrough.send(.failed)
    }
    
    func didConnect(userId: String) {
        connectionPassthrough.send(.userConnected(userId))
    }
    
    func didDisconnect(userId: String) {
        connectionPassthrough.send(.userDisconnected(userId))
    }
}
