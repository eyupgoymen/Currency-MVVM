
//
//  CentAPI.swift
//  Cent
//
//  Created by Eyup Kazım Göymen on 30.07.2019.
//  Copyright © 2019 Eyup Kazım Göymen. All rights reserved.
//

import Moya

enum CentAPI {
    case getCurrencyInfo
    
    case getLatest(based: String)
    case getCurrency(date: String,based: String)
}

extension CentAPI: TargetType {
    var baseURL: URL {
        switch self {
            case .getCurrencyInfo:
                return URL(string: "https://api.appnexus.com/currency")!
            
            default:
                return URL(string: "https://api.exchangeratesapi.io")!
        }
    }
    
    var path: String {
        switch self {
            case .getCurrencyInfo:
                return ""
            case .getLatest(based: _):
                return "latest"
            case .getCurrency(let date, _):
                return "/\(date)"
        }
    }
    
    var method: Method {
        switch self {
            case .getCurrencyInfo:
                return .get
            case .getLatest(based: _):
                return .get
            case .getCurrency(_, _):
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
            case .getCurrencyInfo:
                return .requestPlain
            case .getLatest(let base), .getCurrency(_, let base):
                return .requestParameters(parameters: ["base" : base], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

