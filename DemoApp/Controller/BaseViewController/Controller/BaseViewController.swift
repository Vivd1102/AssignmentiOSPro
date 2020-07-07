//


import UIKit

class BaseViewController: UIViewController {

    var baseVwModel: BaseViewModel? {
        didSet {
            initBaseModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func hideNavigationBar(_ hide: Bool, animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(hide, animated: animated)
    }
    
    // Cann't be override by subclass
    final func initBaseModel() {
        // Native binding
        baseVwModel?.showAlertClosure = { [weak self] (_ type:AlertType) in
            DispatchQueue.main.async {
                if type == .success, let message = self?.baseVwModel?.alertMessage  {
                    UIAlertController.showAlert(title: "", message: message)
                } else {
                    let message = self?.baseVwModel?.errorMessage ?? "Some Error occured"
                    UIAlertController.showAlert(title: "", message: message)
                }
            }
        }
            
        baseVwModel?.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.baseVwModel?.isLoading ?? false
                UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
            }
        }
    }
    
}

