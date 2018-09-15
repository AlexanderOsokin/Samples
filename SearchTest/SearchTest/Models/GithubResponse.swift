//
//  GithubResponse.swift
//  SearchTest
//
//  Created by Edu user on 10/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import Foundation

public struct GithubResponse: Codable {
   let items: [GitUser]
}
