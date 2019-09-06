//
//  FirestoreWrapper.swift
//  Utils
//
//  Created by Toby Youngberg on 9/6/19.
//  Copyright © 2019 Toby Youngberg. All rights reserved.
//

import Foundation

public enum FirestoreWrapperError: Error {
    case documentNotFound
    case unknown
}

public protocol FirestoreWrapperProtocol {
    func initialize()
    func readData(path: String, property: String, completion: @escaping (Result<[String], FirestoreWrapperError>) -> Void)
}
