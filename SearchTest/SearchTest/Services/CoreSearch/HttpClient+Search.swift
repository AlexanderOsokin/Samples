//
//  HttpClient+Search.swift
//  SearchTest
//
//  Created by Edu user on 15/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

extension HttpClient {
	func searchRequest(endpoint: SearchEndpoint, query: String, completed: @escaping (Data?, String?) -> Void) -> Void {
		let urlString = endpoint.rawValue + query
		request(url: urlString)  { data, description in
			completed(data, description)
		}
	}
}
