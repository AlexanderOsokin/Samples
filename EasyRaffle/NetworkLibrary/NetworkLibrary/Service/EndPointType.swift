//
//  EndPointType.swift
//  NetworkLibrary
//
//  Created by Edu user on 20/08/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

protocol EndPointType
{
    var baseUrl: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders? {get}
}
