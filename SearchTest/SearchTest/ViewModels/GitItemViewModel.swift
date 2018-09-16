//
//  LinkCellViewModel.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

class GitItemViewModel {

	var model: GitUser

	init(model: GitUser) {
		self.model = model
	}
}

extension GitItemViewModel: SearchItemViewModel {

	var cellHeight: Float {
		return 88;
	}

	var rtlId: String { get { return SearchItemCellType.RTLGitTableViewCell.rawValue } }
	var ltrId: String { get { return SearchItemCellType.LTRGitTableViewCell.rawValue  } }

	func cellIdentifier(atIndex: Int) -> String {
		return isParity(index: atIndex) ? rtlId: ltrId
	}

	func requestImage(completion: @escaping (Data, String) -> Void) {
		request(url: model.image) { data, descr in
			guard let imageData = data else { return }
			completion(imageData, self.model.image)
		}
	}	
}
