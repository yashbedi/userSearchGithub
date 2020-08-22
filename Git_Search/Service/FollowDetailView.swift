
//
//  FollowDetailView.swift
//  Git_Search
//
//  Created by Yash Bedi on 22/08/20.
//  Copyright © 2020 Yash Bedi LLC. All rights reserved.
//

import Foundation

protocol FollowDetailView: BaseView {
    func set(_ details : [GitUser])
    func setEmptyUsers()
}

extension FollowDetailView {
    func set(_ details : [GitUser]){}
    func setEmptyUsers(){}
}
