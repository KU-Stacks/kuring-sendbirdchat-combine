//
//  OpenChannel.Combine.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

extension BaseChannel {
    public var eventPublisher: AnyPublisher<ChannelEvent, Never> {
        return SendbirdDelegateProxy.shared.channelPassthrough
            .filter { $0.channel == self }
            .map { $0.event }
            .eraseToAnyPublisher()
    }
    
    public func sendUserMessagePublisher(_ message: String) -> AnyPublisher<MessageEvent, MessageFailure> {
        let messageSubject = CurrentValueSubject<MessageEvent?, MessageFailure>(nil)
        
        let tempMessage = sendUserMessage(message) { (message, error) in
            guard let sentMessage = message else {
                if let error = error {
                    messageSubject.send(completion: .failure(.generalFailure(error)))
                    return
                } else {
                    fatalError("Either the value or error must not be nil")
                }
            }
            
            guard error == nil else {
                if let error = error {
                    messageSubject.send(completion: .failure(.sendingFailed(sentMessage, error)))
                    return
                } else {
                    fatalError("Error must not be nil")
                }
            }
            
            messageSubject.send(.sentMessage(sentMessage))
            messageSubject.send(completion: .finished)
        }
        
        messageSubject.value = .tempMessage(tempMessage)
        
        return messageSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    public func deleteUserMessagePublisher(_ userMessage: UserMessage) -> AnyPublisher<Void, SBError> {
        Future<Void, SBError> { [weak self] promise in
            self?.deleteMessage(
                userMessage,
                completionHandler: VoidResult.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
    
    public func deleteMessagePublisher(with messageID: Int64) -> AnyPublisher<Void, SBError> {
        Future<Void, SBError> { [weak self] promise in
            self?.deleteMessage(
                messageId: messageID,
                completionHandler: VoidResult.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
    
    public func resendUserMessagePublisher(_ userMessage: UserMessage) -> AnyPublisher<MessageEvent, MessageFailure> {
        let messageSubject = CurrentValueSubject<MessageEvent?, MessageFailure>(nil)
        
        let tempMessage = resendUserMessage(userMessage) { (message, error) in
            guard let sentMessage = message else {
                if let error = error {
                    messageSubject.send(completion: .failure(.generalFailure(error)))
                    return
                } else {
                    fatalError("Either the value or error must not be nil")
                }
            }
            
            guard error == nil else {
                if let error = error {
                    messageSubject.send(completion: .failure(.sendingFailed(sentMessage, error)))
                    return
                } else {
                    fatalError("Error must not be nil")
                }
            }
            
            messageSubject.send(.sentMessage(sentMessage))
            messageSubject.send(completion: .finished)
        }
        
        messageSubject.value = .tempMessage(tempMessage)
        
        return messageSubject
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    public func messagesPublisherByMessageID(
        _ messageID: Int64,
        params: MessageListParams
    ) -> AnyPublisher<[BaseMessage], SBError> {
        Future<[BaseMessage], SBError> { [weak self] promise in
            self?.getMessagesByMessageId(
                messageID,
                params: params,
                completionHandler: Result.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
    
    public func messagesPublisherByTimestamp(
        _ timestamp: Int64,
        params: MessageListParams
    ) -> AnyPublisher<[BaseMessage], SBError> {
        Future<[BaseMessage], SBError> { [weak self] promise in
            self?.getMessagesByTimestamp(
                timestamp,
                params: params,
                completionHandler: Result.handle(promise: promise)
            )
        }
        .eraseToAnyPublisher()
    }
}
