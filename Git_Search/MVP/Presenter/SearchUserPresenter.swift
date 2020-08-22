//
//  SearchUserPresenter.swift
//  Git_Search
//
//  Created by Yash Bedi on 18/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation


struct SearchUserPresenter: BaseUserPresenterProtocol {
    
    private let service: SearchUsersService
    private var view: SearchUsersView?
    
    init(_ service: SearchUsersService){
        self.service = service
    }
    
    mutating func attach(_ view: SearchUsersView){
        self.view = view
    }
    
    mutating func detachView(){
        self.view = nil
    }
    
    func getUsersFor(_ query: String, pageNum: Int){
        view?.startLoading()
        service.fetchUsersFrom(query: query, pageNum: pageNum) { (searchedUser) in
            self.view?.stopLoading()
            guard let searchedUsers = searchedUser else {
                self.view?.setEmptyUsers()
                return
            }
            self.view?.set(users: searchedUsers.items)
        }
    }
    
    func getImage(from url: URL, completion: @escaping ImageCompletion) {
        service.getImage(from: url) { (imageData) in
            completion(imageData)
        }
    }
}
