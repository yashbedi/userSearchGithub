//
//  BaseView.swift
//  Git_Search
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation

protocol BaseView: NSObjectProtocol {
    func startLoading()
    func stopLoading()
}
extension BaseView {
    func startLoading(){}
    func stopLoading(){}
}
