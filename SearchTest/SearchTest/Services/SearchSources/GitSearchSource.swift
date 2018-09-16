//
//  GitSearchSource.swift
//  SearchTest
//
//  Created by Edu user on 11/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

class GitSearchSource {

	private var httpClient: HttpClient

	init(httpClient: HttpClient) {
		self.httpClient = httpClient
	}
}

extension GitSearchSource: SearchSource {

	func search(query: String, searchComplete: @escaping ([SearchItemViewModel], String?) -> Void)  {
		httpClient.searchRequest(endpoint: .github, query: query) {
			[unowned self]
			data, description in
			guard let jsonData = data else {
				searchComplete([], description)
				return
			}
			guard let response: GithubResponse = self.parseResponse(data: jsonData) else {
				searchComplete([], "Failed to parse json")
				return
			}
			let searchItems = response.items.map({(gitUser) -> GitItemViewModel in
				return GitItemViewModel(model: gitUser)
			})
			searchComplete(searchItems, nil)
		}
	}
}
