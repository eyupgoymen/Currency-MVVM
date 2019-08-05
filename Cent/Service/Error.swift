//
//  Error.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

enum CentError : Error {
    case serviceError(error: String)
    case unknown
}

extension CentError:  LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .serviceError(let desc):
                return NSLocalizedString(desc, comment: "Error")
            case .unknown:
                return NSLocalizedString("UnexpectedError", comment: "Error")
        }
    }
}
