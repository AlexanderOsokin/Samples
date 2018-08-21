//
//  PaprameterEncoder.swift
//  NetworkLibrary
//
//  Created by Edu user on 21/08/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public protocol ParameterEncoder{
    static func encode(urlRequest: inout URLRequest, with parameters:
    Parameters) throws
}
