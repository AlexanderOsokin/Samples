//
//  SearchViewModel.swift
//  SearchTest
//
//  Created by Edu user on 15/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

protocol SearchItemViewModel: Any {
	func cellIdentifier(atIndex: Int) -> String
	var cellHeight: Float {get}
	func requestImage(completion: @escaping (Data, String) -> Void)
}

extension SearchItemViewModel {
	func isParity(index: Int) -> Bool {
		if index == 0 { return false }
		if index % 2 != 0  { return true }
		return false
	}
}

extension SearchItemViewModel {
	func request(url: String, completion: @escaping (Data?, String?)->Void) -> Void {

		guard let requestUrl = URL(string:url) else {
			completion(nil,"failed to create Url")
			return
		}
		let request = URLRequest(url:requestUrl)
		let task = URLSession.shared.dataTask(with: request) {
			(data, response, error) in
			completion(data, error?.localizedDescription)
		}
		task.resume()
	}
}
