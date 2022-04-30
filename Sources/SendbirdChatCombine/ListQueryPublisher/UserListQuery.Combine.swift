//
//  UserListQuery.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

extension UserListQuery {
    public func nextPagePublisher() -> AnyPublisher<[User], SBError> {
        Future<[User], SBError> { [weak self] promise in
            self?.loadNextPage(completionHandler: Result.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }
}
