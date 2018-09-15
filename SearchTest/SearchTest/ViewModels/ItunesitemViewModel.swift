//
//  File.swift
//  SearchTest
//
//  Created by Edu user on 15/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public class ItunesItemViewModel {

	var model: ItunesItem

	init(model: ItunesItem) {
		self.model = model
	}
}

extension ItunesItemViewModel: SearchItemViewModel {
	var cellHeight: Float {
		return 88;
	}

	var rtlId: String { get { return SearchItemCellType.RTLItunesTableViewCell.rawValue } }
	var ltrId: String { get { return SearchItemCellType.LTRItunesTableViewCell.rawValue  } }

	func cellIdentifier(atIndex: Int) -> String {
		return isParity(index: atIndex) ? ltrId: rtlId
	}
	
	func requestImage(completion: @escaping (Data, String) -> Void) {
		request(url: model.image) { data, descr in
			guard let imageData = data else { return }
			completion(imageData, self.model.image)
		}
	}
}
