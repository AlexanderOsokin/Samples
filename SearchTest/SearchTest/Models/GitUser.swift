//
//  GitUser.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

struct GitUser: Codable {
    let login: String
    let url: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case url = "html_url"
        case image = "avatar_url"
    }
}
