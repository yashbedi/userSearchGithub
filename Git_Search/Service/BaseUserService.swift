//
//  BaseUserService.swift
//  Git_Search
//
//  Created by Yash Bedi on 21/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation

typealias ImageCompletion = (Data)->Swift.Void
typealias SearchQueryCompletion = (GitSearchedUser?)->Swift.Void
typealias UserDetailsCompletion = (UserDetailsModel?)->Swift.Void
typealias UserDetailsFollowList = ([GitUser]?)->Swift.Void

class BaseUserService {
    
    func getImage(from url: URL, completion: @escaping ImageCompletion) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _data = data { completion(_data) }
        }.resume()
    }
}
