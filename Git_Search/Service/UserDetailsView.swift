//
//  UserDetailsView.swift
//  Git_Search
//
//  Created by Yash Bedi on 21/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation

protocol UserDetailsView: BaseView {
    func set(_ details : UserDetailsModel)
    func setEmptyUser()
}

extension UserDetailsView {
    func set(_ details : UserDetailsModel){}
    func setEmptyUser(){}
}
