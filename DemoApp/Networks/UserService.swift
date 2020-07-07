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
        
    func dofectlisting(completion:@escaping (NSDictionary?) -> Void)
}

public class UserService: APIService, UserServiceProtocol {

    func dofectlisting( completion: @escaping (NSDictionary?) -> Void) {

        super.startService(with: .GET, parameters: nil,files: []) { (result) in
              DispatchQueue.main.async {
                  switch result {
                  case .Success(let response):
                      // #parse response here
                      if let data = response{
                        completion(data as? NSDictionary)
                      } else {
                          completion(nil)
                      }
                  case .Error( _):
                      // #display error message here
                      completion(nil)
                  }
              }
          }
        
        
    }
}

