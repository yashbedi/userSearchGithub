//
//  SearchUsersService.swift
//  Git_Search
//
//  Created by Yash Bedi on 21/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation
import Alamofire


final class SearchUsersService: BaseUserService {
    
    func fetchUsersFrom(query string: String, pageNum: Int, onCompletion: @escaping SearchQueryCompletion){
        guard
            let url = URL(string: "\(baseUrl)search/users?q=\(string.lowercased())&page=\(pageNum)&per_page=15")
            else {
                onCompletion(nil)
                return
        }
        Alamofire.request(url).responseJSON { response in
            
            guard
                let jsonData = response.data else  {
                    onCompletion(nil)
                    return
            }
            let decoder = JSONDecoder()
            do {
                let gitSearchedUsers = try decoder.decode(GitSearchedUser.self,
                                                          from: jsonData)
                onCompletion(gitSearchedUsers.totalCount < 1 ? nil : gitSearchedUsers)
            } catch {
                onCompletion(nil)
            }
        }
    }
}
