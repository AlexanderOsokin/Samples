//
//  Router.swift
//  NetworkLibrary
//
//  Created by Edu user on 21/08/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter{
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do{
            let request = try buildRequest(from:route)
            task = session.dataTask(with: request, completionHandler: {data,response,error in completion(data,response,error)})
        }catch{
            completion(nil,nil,error)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do{
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .requestParametersAndHeader(let bodyParameters, let urlParameters, let additionHeaders):
                self.addAdditionalHeaders(additionHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        }catch{
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do{
            if let bodyParameters = bodyParameters{
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters{
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        }catch{
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest){
        guard let headers = additionalHeaders else {return}
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
