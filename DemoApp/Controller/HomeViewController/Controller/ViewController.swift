//
//  ViewController.swift
//  DemoApp
//
//  Created by vivek bajirao deshmukh on 24/06/20.
//  Copyright © 2020 vivek bajirao deshmukh. All rights reserved.
//

import UIKit
import SDWebImage
import MaterialActivityIndicator

class ViewController: BaseViewController{
    
    var tableView = UITableView()
    private let indicator = MaterialActivityIndicatorView()

    lazy var viewModel: HomeViewModel = {
        let obj = HomeViewModel(userService: UserService())
        self.baseVwModel = obj
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupActivityIndicatorView()
        self.setUpNavigation()
        self.setUpTableview()
        
        //self.apiCall()
        self.initViewModel()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicator.startAnimating()
    }
    
    func setUpNavigation() {
     self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
     self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    func setUpTableview(){
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        // register your class with cell identifier
        self.tableView.register(myCell.self as AnyClass, forCellReuseIdentifier: "Cell")
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func initViewModel() {
            viewModel.reloadListViewClosure = { [weak self] () in
                DispatchQueue.main.async {
                    self?.indicator.stopAnimating()
                    self?.tableView.reloadData()
                }
            }
        viewModel.fetchListing()
        }
        
}
// MARK: - Tableview Delagte methods

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Tableview delegate
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:myCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? myCell
            cell?.listing = viewModel.roomForIndexPath(indexPath)
           self.title = viewModel.title
           return cell!
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return viewModel.numberOfRow(section)
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return viewModel.heightForIndexPath(indexPath)
        }
}
// MARK: - Custom Cell
class myCell: UITableViewCell {

       let containerView:UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.clipsToBounds = true // this will make sure its children do not go out of the boundary
           return view
       }()
       
       let profileImageView:UIImageView = {
           let img = UIImageView()
           img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
           img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
           img.clipsToBounds = true
           return img
       }()
       
       let nameLabel:UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 14)
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       let jobTitleDetailedLabel:UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 10)
           label.textColor =  .darkGray
           label.numberOfLines = 5
           label.layer.cornerRadius = 5
           label.clipsToBounds = true
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
       
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           self.contentView.addSubview(profileImageView)
           containerView.addSubview(nameLabel)
           containerView.addSubview(jobTitleDetailedLabel)
           self.contentView.addSubview(containerView)
           
           profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
           profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
           profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
           profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
           
           containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
           containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
           containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
           containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
           
           nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
           nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
           nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
           
           jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
           jobTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
           jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
           jobTitleDetailedLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
    open var listing:Rows? {
            didSet {
                
                self.nameLabel.text  = listing?.title
                self.jobTitleDetailedLabel.text = listing?.description
                DispatchQueue.main.async {
                    self.profileImageView.sd_setImage(with: URL(string: (self.listing?.imageHref ?? "")), placeholderImage: UIImage(named: ""))
                }
            }
        }
}

extension ViewController{
    private func setupActivityIndicatorView() {
        self.view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
    }

    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
