//
//  GitSearchSource.swift
//  SearchTest
//
//  Created by Edu user on 11/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public class GitSearchSource {

	private weak var httpClient: HttpClient!

	init(httpClient: HttpClient) {
		self.httpClient = httpClient
	}
}

extension GitSearchSource: SearchSource {

	func search(query: String, searchComplete: @escaping ([SearchItemViewModel]) -> Void)  {
		httpClient.searchRequest(endpoint: .github, query: query) { [unowned self] data, description in
			guard let jsonData = data,
				let response: GithubResponse = self.parseResponse(data: jsonData) else { searchComplete([]); return }
			let searchItems = response.items.map({(gitUser) -> GitItemViewModel in
				return GitItemViewModel(model: gitUser)
			})
			searchComplete(searchItems)
		}
	}
}
