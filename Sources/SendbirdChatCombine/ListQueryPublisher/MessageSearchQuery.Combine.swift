//
//  MessageSearchQuery.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

extension MessageSearchQuery {
    public func loadNextPage() -> AnyPublisher<[BaseMessage], SBError> {
        Future<[BaseMessage], SBError> { [weak self] promise in
            self?.loadNextPage(completionHandler: Result.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }
}

