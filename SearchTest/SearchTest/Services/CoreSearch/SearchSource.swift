//
//  SearchSource.swift
//  SearchTest
//
//  Created by Edu user on 11/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

protocol SearchSource {
	func search(query: String, searchComplete: @escaping  ([SearchItemViewModel], String?) -> Void ) -> Void
}

extension SearchSource {

	func parseResponse<DecodableType: Decodable>(data: Data) -> DecodableType? {
		do {
			let decoder = JSONDecoder()
			let response = try decoder.decode(DecodableType.self, from: data)
			return response
		}
		catch {
			print(error)
		}
		return nil
	}
}
