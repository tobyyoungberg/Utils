//
//  WebRequestProtocol.swift
//  
//
//  Created by Toby Youngberg on 8/20/19.
//

import Foundation

public enum WebRequestError: Error {
    case unknown
}

public protocol WebRequestProtocol {
    func request(url: URL, completion: @escaping (Swift.Result<Data, WebRequestError>) -> Void)
}
