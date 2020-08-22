//
//  FollowDetailPresenter.swift
//  Git_Search
//
//  Created by Yash Bedi on 22/08/20.
//  Copyright © 2020 Yash Bedi LLC. All rights reserved.
//

import Foundation


struct FollowDetailPresenter: BaseUserPresenterProtocol {
    private let service: FollowDetailService
    private var view: FollowDetailView?
    
    init(_ service: FollowDetailService){
        self.service = service
    }
    
    mutating func attach(_ view: FollowDetailView){
        self.view = view
    }
    
    mutating func detachView(){
        self.view = nil
    }
    
    func getUsersFor(_ name: String, viewFollowers: Bool){
        view?.startLoading()
        service.userFollowers(from: name,
                              viewFollowers: viewFollowers) { (users) in
                                self.view?.stopLoading()
                                guard let _users = users else {
                                    self.view?.setEmptyUsers()
                                    return
                                }
                                self.view?.set(_users)
        }
    }
    func getImage(from url: URL, completion: @escaping ImageCompletion) {
        service.getImage(from: url) { (imageData) in
            completion(imageData)
        }
    }
}
