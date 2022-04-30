//
//  OpenChannel.Combine.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

extension OpenChannel {
    public static func channelPublisherWithUrl(_ url: String) -> AnyPublisher<OpenChannel, SBError> {
        Future<OpenChannel, SBError> { promise in
            OpenChannel.getChannel(url: url, completionHandler: Result.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }

    public func enterPublisher() -> AnyPublisher<Void, SBError> {
        Future<Void, SBError> { [weak self] promise in
            self?.enter(completionHandler: VoidResult.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }

    public func exitChannelPublisher() -> AnyPublisher<Void, SBError> {
        Future<Void, SBError> { [weak self] promise in
            self?.exit(completionHandler: VoidResult.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }

    public func refreshChannelPublisher() -> AnyPublisher<Void, SBError> {
        Future<Void, SBError> { [weak self] promise in
            self?.refresh(completionHandler: VoidResult.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }
}
