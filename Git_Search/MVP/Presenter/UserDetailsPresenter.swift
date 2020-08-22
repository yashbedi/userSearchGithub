//
//  UserDetailsPresenter.swift
//  Git_Search
//
//  Created by Yash Bedi on 21/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation


struct UserDetailsPresenter: BaseUserPresenterProtocol {
    
    private let service: DetailUserService
    
    private var view: UserDetailsView?
    
    init(_ service: DetailUserService){
        self.service = service
    }
    
    mutating func attach(_ view: UserDetailsView){
        self.view = view
    }
    
    mutating func detachView(){
        self.view = nil
    }
    
    func getUserDetails(from userName: String){
        view?.startLoading()
        
        service.getUserDetails(from: userName) { (userDetails) in
            self.view?.stopLoading()
            guard
                let detailsOfTheUser = userDetails
                else {
                    self.view?.setEmptyUser()
                    return
            }
            self.view?.set(detailsOfTheUser)
        }
    }
    
    func getImage(from url: URL, completion: @escaping ImageCompletion) {
        service.getImage(from: url) { (imageData) in
            completion(imageData)
        }
    }
}
