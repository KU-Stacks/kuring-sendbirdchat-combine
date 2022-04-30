//
//  Commons.swift
//  
//
//  Created by Jaesung Lee on 2022/04/30.
//

import Foundation
import Combine
import SendbirdChatSDK

typealias VoidResult = Result<Void, SBError>

extension Result {
    static func handle(promise: @escaping Future<Success, Failure>.Promise) -> (Success?, Failure?) -> Void {
        return { value, error in
            let result: Result<Success, Failure>
            if let value = value {
                result = .success(value)
            } else if let error = error {
                result = .failure(error)
            } else {
                fatalError("Either the value or error must not be nil")
            }
            promise(result)
        }
    }

    static func handle(promise: @escaping Future<Void, Failure>.Promise) -> (Failure?) -> Void {
        return { error in
            let result: Result<Void, Failure>
            if let error = error {
                result = .failure(error)
            } else {
                result = .success(())
            }
            promise(result)
        }
    }
}
