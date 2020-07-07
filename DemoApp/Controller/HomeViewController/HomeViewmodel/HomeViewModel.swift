//
//  HomeViewModel.swift
//  FantomLED
//
//  Created by Surjeet Singh on 02/07/18.
//  Copyright © 2018 Surjeet Singh. All rights reserved.
//

import UIKit
//import MaterialActivityIndicator

class HomeViewModel: BaseViewModel {
    
    var userService: UserServiceProtocol


    private var listingArray:[Base] = [Base]() {
        didSet {
            self.reloadListViewClosure?()
        }
    }
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    
    
    open func numberOfSections() -> Int {
        return 1
    }
    
    open func numberOfRow(_ section: Int) -> Int {
        return self.listingArray.count
    }
    
    open func roomForIndexPath(_ indexPath: IndexPath) -> Base {
        return self.listingArray[indexPath.row]
    }
    
    open func heightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
//        if self.listingArray[indexPath.row].enable == true {
//            return 80
//        }
        return 360
    }
    
    open func checkForOnStatus() -> Bool {

//        let filtered = self.listingArray.filter({$0.enable == true})
//        if filtered.count > 0 {
//            return true
//        }
        return false
    }
    
    open func fetchListing() {
        self.isLoading = true
        //TODO: Call your api here
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.isLoading = false
//            print("Page number",pagenum,limit)
            self.userService.dofectlisting() { (result) in
                
                
                if let user = result {
                    for item in user {
                        let postobj = Base.init(dictionary: item)
                        self.listingArray.append(postobj!)
                    }
                }else{
                    
                }
                
            }
        }
    }
    
//    private func getTempArray() -> [Base] {
//
//        let base = Base(id: "0", createdAt: "12 PM", content: "Content not avilable", comments: 0, likes: 0, media: [], user: [])
////        let list1 = Listing(name: "User 1", subTitle: "subtitle 1", enable: true)
////        let list2 = Listing(name: "User 2", subTitle: "subtitle 2", enable: true)
////        let list3 = Listing(name: "User 3", subTitle: "subtitle 3", enable: false)
////        let list4 = Listing(name: "User 4", subTitle: "subtitle 4", enable: true)
////        let list5 = Listing(name: "User 5", subTitle: "subtitle 5", enable: false)
////        return [list1, list2, list3, list4, list5]
//            return [base]
//    }
}
