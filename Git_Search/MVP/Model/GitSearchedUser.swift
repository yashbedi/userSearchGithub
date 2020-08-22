//
//  GitSearchedUser.swift
//  Git_Search
//
//  Created by Yash Bedi on 19/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation

// MARK: - GitUserSearch
public struct GitSearchedUser: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GitUser]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}


struct GitUser: Codable {
    let login: String?
    let htmlURL: String?
    let avatarURL: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case login, type
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
