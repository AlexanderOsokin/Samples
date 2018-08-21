//
//  NetworkError.swift
//  NetworkLibrary
//
//  Created by Edu user on 21/08/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error{
    case parametersNil  = "Parameters were nil"
    case encodingFailed = "Parameter encoding failed"
    case missingUrl     = "Url is nil"
}
