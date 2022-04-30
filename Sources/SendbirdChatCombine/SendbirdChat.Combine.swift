//
//  SendbirdChat.Combine.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

extension SendbirdChat {
    public static var connectionEventPublisher: AnyPublisher<ConnectionEvent, Never> {
        return SendbirdDelegateProxy.shared.connectionPassthrough.eraseToAnyPublisher()
    }
    
    public static func connectPublisher(userId: String, authToken: String? = nil) -> AnyPublisher<User, SBError> {
        Future<User, SBError> { promise in
            connect(
                userId: userId,
                authToken: authToken,
                completionHandler: Result.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
    
    public static func disconnectPublisher() -> AnyPublisher<Void, Never> {
        Future<Void, Never> { promise in
            disconnect {
                return promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public static func updateCurrentUserInfoPublisher(nickname: String) -> AnyPublisher<Void, SBError> {
        Future<Void, SBError> { promise in
            let params = UserUpdateParams()
            params.nickname = nickname
            updateCurrentUserInfo(
                params: params,
                completionHandler: VoidResult.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
    
    public static func registerPushTokenPublisher(_ deviceToken: Data, unique: Bool) -> AnyPublisher<PushTokenRegistrationStatus, SBError> {
        Future<PushTokenRegistrationStatus, SBError> { promise in
            registerDevicePushToken(
                deviceToken,
                unique: unique,
                completionHandler: Result.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
    
    public static func unregisterPushTokenPublisher(_ deviceToken: Data) -> AnyPublisher<[AnyHashable: Any], SBError> {
        Future<[AnyHashable: Any], SBError> { promise in
            unregisterPushToken(
                deviceToken,
                completionHandler: Result.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
    
    public static func unregisterAllPushTokenPublisher() -> AnyPublisher<[AnyHashable: Any], SBError> {
        Future<[AnyHashable: Any], SBError> { promise in
            unregisterAllPushToken(completionHandler: Result.handle(promise: promise))
        }
        .eraseToAnyPublisher()
    }
}
