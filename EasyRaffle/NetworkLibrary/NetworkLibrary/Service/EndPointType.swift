//
//  EndPointType.swift
//  NetworkLibrary
//
//  Created by Edu user on 20/08/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

protocol EndpointType
{
    var baseUrl: Url {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HttpTask {get}
    var headers: HttpHeaders? {get}
}
