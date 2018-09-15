//
//  ItunesSearchSource.swift
//  SearchTest
//
//  Created by Edu user on 15/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public class ItunesSearchSource {

	private weak var httpClient: HttpClient!

	init(httpClient: HttpClient) {
		self.httpClient = httpClient
	}
}

extension ItunesSearchSource: SearchSource {

	func search(query: String, searchComplete: @escaping ([SearchItemViewModel]) -> Void)  {
		httpClient.searchRequest(endpoint: .itunes, query: query) { [unowned self] data, description in
			guard let jsonData = data,
				let response: ItunesResponse = self.parseResponse(data: jsonData) else { searchComplete([]); return }
			let searchItems = response.results.map({(item) -> ItunesItemViewModel in
				return ItunesItemViewModel(model: item)
			})
			searchComplete(searchItems)
		}
	}
}
