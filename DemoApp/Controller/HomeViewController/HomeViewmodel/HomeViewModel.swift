//
//  HomeViewModel.swift
//

import UIKit
import MaterialActivityIndicator

class HomeViewModel: BaseViewModel {

    var userService: UserServiceProtocol
    var title : String = ""

    private var listingArray:[Rows] = [Rows]() {
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
    
    open func roomForIndexPath(_ indexPath: IndexPath) -> Rows {
        return self.listingArray[indexPath.row]
    }
    
    open func heightForIndexPath(_ indexPath: IndexPath) -> CGFloat {
        return 80
    }
// MARK:- API CALL
    open func fetchListing() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.isLoading = false
            self.userService.dofectlisting() { (result) in
                if let user = result{
                    let obj = Base.init(dictionary: user)
                    self.title = obj?.title ?? ""
                    for modelobj in obj?.rows ?? []{
                        self.listingArray.append(modelobj)
                    }
                }else{
                    print("")
                }
            }
        }
    }
    
}
