//
//  BaseUserPresenter.swift
//  Git_Search
//
//  Created by Yash Bedi on 22/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation

protocol BaseUserPresenterProtocol {
    func getImage(from url: URL, completion: @escaping ImageCompletion)
}
