//
//  GithubResponse.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

struct GithubResponse: Codable {
   let items: [GitUser]
}
