//
//  OpenChannelListQuery.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

extension OpenChannelListQuery {
    public func nextPagePublisher() -> AnyPublisher<[OpenChannel], SBError> {
        Future<[OpenChannel], SBError> { [weak self] promise in
            self?.loadNextPage(completionHandler: Result.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }
}
