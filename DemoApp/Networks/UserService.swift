//
//  LoginAPIManager.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit

protocol UserServiceProtocol {
    
//    func doLogin(email: String, password:String, completion:@escaping (Result<Any>) -> Void)
    
    func dofectlisting(completion:@escaping ([NSDictionary]?) -> Void)
}

public class UserService: APIService, UserServiceProtocol {
    
    
    
    
    func dofectlisting(completion: @escaping ([NSDictionary]?) -> Void) {
        
        guard let url = URL(string: Config.baseUrl) else {
            print("Error unwrapping URL"); return }
        
        //4 - create a session and dataTask on that session to get data/response/error
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            //5 - unwrap our returned data
            guard let unwrappedData = data else { print("Error getting data"); return }
            
            do {
                //6 - create an object for our JSON data and cast it as a NSDictionary
                // .allowFragments specifies that the json parser should allow top-level objects that aren't NSArrays or NSDictionaries.
                if let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? Any {
                    
                    //7 - create an array of dictionaries from
//                    let json = responseJSON
                    completion(responseJSON as? [NSDictionary])
                }
            } catch {
                //9 - if we have an error, set our completion with nil
                completion(nil)
                print("Error getting API data: \(error.localizedDescription)")
            }
        }
        //10 -
        dataTask.resume()
        
        
    }
}

