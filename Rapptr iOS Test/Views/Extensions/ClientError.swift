//
//  ChatClientError.swift
//  Rapptr iOS Test
//
//  Created by Sebastian Banks on 5/9/22.
//

import Foundation

enum ClientError: LocalizedError {
    
    case invalidError
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidError:
            return "Server failed to reach the necessary url"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription), \(error)"
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "Faild to decode the data"
        }
    }
}

