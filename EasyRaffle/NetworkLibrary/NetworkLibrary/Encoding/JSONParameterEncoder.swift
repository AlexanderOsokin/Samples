//
//  JSONParameterEncoder.swift
//  NetworkLibrary
//
//  Created by Edu user on 21/08/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder{
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do{
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if(urlRequest.value(forHTTPHeaderField: "Content-Type") == nil){
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch{
            throw NetworkError.encodingFailed
        }
    }
}
