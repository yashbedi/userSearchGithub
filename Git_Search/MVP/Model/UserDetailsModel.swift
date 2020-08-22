//
//  UserDetailsModel.swift
//  Git_Search
//
//  Created by Yash Bedi on 21/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation

// MARK: - UserDetailsModel
struct UserDetailsModel: Codable {
    var login: String?
    var avatarURL: String?
    var htmlURL: String?
    var type: String?
    var siteAdmin: Bool?
    var name, company: String?
    var blog: String?
    var location: String?
    var email, bio, twitterUsername: String?
    var hireable : Bool?
    var publicRepos, publicGists, followers, following: Int?
    var createdAt, updatedAt: String?

    init() {
        login = ""
        avatarURL = ""
        htmlURL = ""
        type = ""
        siteAdmin = false
        blog = ""
        location = ""
        name = ""
        company = ""
        email = ""
        bio = ""
        twitterUsername = ""
        publicRepos = 0
        publicGists = 0
        followers = 0
        following = 0
        createdAt = ""
        updatedAt = ""
        hireable = false
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
