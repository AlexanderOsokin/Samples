//
//  ItunesItem.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

struct ItunesItem: Codable {
	let title: String
	let author: String
	let image: String

	enum CodingKeys: String, CodingKey {
		case title = "wrapperType"
		case author = "artistName"
		case image = "artworkUrl100"
	}
}
