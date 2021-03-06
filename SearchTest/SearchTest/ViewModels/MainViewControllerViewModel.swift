//
//  TableViewModel.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

protocol TableViewModelDelegate: AnyObject {
    func dataChanged() -> Void
	func error(description: String) -> Void
}

class MainViewControllerViewModel {

	private var timer: Timer = Timer()
    private var items: [SearchItemViewModel] = []
	private var searchSources: [SearchSourceType: SearchSource] = [:]

	private weak var httpClient: HttpClient?
    weak var delegate: TableViewModelDelegate?

	var currentSource: SearchSourceType = .github

	var itemsCount: Int {
		get {
			return items.count
		}}

	var hasItems: Bool {
		get {
			return items.count>0
		}
	}

	init(searchSources: [SearchSourceType: SearchSource], httpClient: HttpClient) {

        self.searchSources = searchSources
		self.httpClient = httpClient
    }

    func search(query: String, sourceType: SearchSourceType) {

		guard searchSources.count != 0 else { return }

        timer.invalidate()

		if query.count == 0 {

			httpClient?.cancelRequest()

			if (items.count > 0) {
				items = []
				delegate?.dataChanged()
			}
			return
		}

		guard query.count > 2 else { return }

		timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [unowned self] t in
			if let searchSource = self.searchSources[self.currentSource] {
				searchSource.search(query: query) {[unowned self] results, error in
					self.items = results
					self.delegate?.dataChanged()

					if let error = error {
						self.delegate?.error(description: error)
					}
					else if (results.isEmpty) {
						self.delegate?.error(description: "Nothing to be found")
					}
				}
			}
		}
    }

	func cellViewModel(index: Int) -> SearchItemViewModel {
		return items[index]
	}
}
