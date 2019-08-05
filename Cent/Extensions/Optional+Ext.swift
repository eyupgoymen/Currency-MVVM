//
//  Optional+Ext.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
            case .some(let value):
                return value
            case .none:
                return ""
        }
    }
}

extension Optional {
    struct FoundNilWhileUnwrappingError: Error { }
    
    func unwrap() throws -> Wrapped {
        switch self {
            case .some(let value):
                return value
            case .none:
                throw FoundNilWhileUnwrappingError()
        }
    }
}
