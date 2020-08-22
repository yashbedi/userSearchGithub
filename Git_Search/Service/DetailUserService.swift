//
//  DetailUserService.swift
//  Git_Search
//
//  Created by Yash Bedi on 21/08/20.
//  Copyright © 2020 Yash Bedi. All rights reserved.
//

import Foundation
import Alamofire

final class DetailUserService: BaseUserService {
    
    func getUserDetails(from username: String, onCompletion: @escaping UserDetailsCompletion){
        
        guard
            let url = URL(string: "\(baseUrl)users/\(username)")
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
                let userDetails = try decoder.decode(UserDetailsModel.self,
                                                          from: jsonData)
                onCompletion(userDetails)
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                NSLog("Key '\(key)' not found:", context.debugDescription)
                NSLog("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                NSLog("Value '\(value)' not found:", context.debugDescription)
                NSLog("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                NSLog("Type '\(type)' mismatch:", context.debugDescription)
                NSLog("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
}
