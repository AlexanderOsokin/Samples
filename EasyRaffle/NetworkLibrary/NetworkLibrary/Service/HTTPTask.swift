//
//  HTTPTask.swift
//  NetworkLibrary
//
//  Created by Edu user on 21/08/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask
{
    case request
    
    case requestParameters(
        bodyParameters: Parameters?,
        urlParameters: Parameters?)
    
    case requestParametersAndHeader(
        bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
