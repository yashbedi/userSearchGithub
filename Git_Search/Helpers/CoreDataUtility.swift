//
//  CoreDataUtility.swift
//  GitUserSearch
//
//  Created by Yash Bedi on 20/08/20.
//  Copyright © 2018 Yash Bedi. All rights reserved.
//

import UIKit
import CoreData

final class CoreDataUtility {
    
    private init() { }
    
    static let shared = CoreDataUtility()
    
    func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }
    
    func retireveUsers() -> [UserDetailsModel] {
        var usersArray = Array<UserDetailsModel>()
        var results:[AnyObject]?
        let currentContext = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kGitUserEntity)
        do{
            results = try currentContext.fetch(fetchRequest) as? [GitUserEntity]
            if let _results = results {
                for item in _results {
                    let gitUser = getGitUserFromEntity(gitUserEntity: item as! GitUserEntity)
                    usersArray.append(gitUser)
                }
            }
            return usersArray
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return usersArray
    }
    
    func save(user: UserDetailsModel) {
        let currentContext = getContext()
        let gitUserEntity = NSEntityDescription.insertNewObject(forEntityName: kGitUserEntity,
                                                                into: currentContext) as? GitUserEntity
        gitUserEntity?.avatarURL = user.avatarURL
        gitUserEntity?.htmlURL = user.htmlURL
        gitUserEntity?.login = user.login
        gitUserEntity?.location = user.location
        gitUserEntity?.name = user.name
        do {
            try currentContext.save()
        }
        catch let error as NSError{
            NSLog(error.localizedDescription)
        }
    }
    
    func getGitUserFromEntity(gitUserEntity: GitUserEntity) -> UserDetailsModel{
        var user = UserDetailsModel()
        user.login = gitUserEntity.login
        user.htmlURL = gitUserEntity.htmlURL
        user.avatarURL = gitUserEntity.avatarURL
        user.location = gitUserEntity.location
        user.name = gitUserEntity.name
        return user
    }
    
    func deleteRecords() {
        let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: kGitUserEntity)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print (CORE_DATA.DELETE_ERROR.rawValue)
        }
    }
}
