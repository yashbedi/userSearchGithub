//
//  SearchUsersView.swift
//  Git_Search
//
//  Created by Yash Bedi on 18/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation

protocol SearchUsersView: BaseView {
    func set(users : [GitUser])
    func setEmptyUsers()
}

extension SearchUsersView {
    func set(users : [GitUser]){}
    func setEmptyUsers(){}
}
