//
//  SearchItemCellType.swift
//  SearchTest
//
//  Created by Edu user on 15/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

enum SearchItemCellType: String {
	case RTLGitTableViewCell
	case LTRGitTableViewCell
	case RTLItunesTableViewCell
	case LTRItunesTableViewCell
}

extension SearchItemCellType {

	static func toStringArray() -> [String] {
		return [RTLGitTableViewCell.rawValue,
				LTRGitTableViewCell.rawValue,
				RTLItunesTableViewCell.rawValue,
				LTRItunesTableViewCell.rawValue]
	}
}


