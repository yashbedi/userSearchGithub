//
//  Constants.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import Foundation




enum CORE_DATA : String{
    case SAVE_ERROR
    case DELETE_ERROR
    case RETRIEVAL_ERROR
}

enum LOADING_HUD : String {
    case LOADING = "Loading.."
    case WAIT = "Please Wait"
}

enum REACHABILITY : String {
    case NOTIFICATION_NAME = "ReachabilityChangedNotification"
    case ERROR = "could not start reachability notifier"
    case NETWORK_UNAVAILABLE
    case NETWORK_AVAILABLE
    
}

public let H_FONT = "Helvetica Neue"
public let NO_USER_FOUND = "No User Found"
public let POWERED_BY_GITHUB = "Powered By Github"
public let ReachabilityChangedNotification = NSNotification.Name(REACHABILITY.NOTIFICATION_NAME.rawValue)

public let UserName = "UserName"

public let Password = "Password"

public let baseUrl = "https://api.github.com/"

public let kGitUserCell = "GitUserCell"

public let kCachedCell = "CachedCell"

public let kGitUserEntity = "GitUserEntity"

public let kUserNotFound = "Couldn't find this user.\nAre you spelling the username\ncorrectly ?"

public let kGitUserSearch = "Git User Search"

public let kUserDetailsCell = "UserDetailsCell"

public let kUsersProfileCell = "UsersProfileCell"

