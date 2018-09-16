//
//  SearchClient.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

class HttpClient {

	private var requestTask: URLSessionDataTask?

	func request(url: String, completion: @escaping (Data?, String?)->Void) -> Void {

		requestTask?.cancel()

		let formattedUrl = url.replacingOccurrences(of: " ", with: "+")

		guard let requestUrl = URL(string:formattedUrl) else {
			completion(nil,"failed to create Url")
			return
		}
		let request = URLRequest(url:requestUrl)
		requestTask = URLSession.shared.dataTask(with: request) {
			(data, response, error) in

			if let error = error as NSError? {
				if error.code == NSURLErrorCancelled {
					return
				}
			}

			completion(data, error?.localizedDescription)
		}
		requestTask?.resume()

	}

	func cancelRequest() -> Void {
		requestTask?.cancel()
	}
}
