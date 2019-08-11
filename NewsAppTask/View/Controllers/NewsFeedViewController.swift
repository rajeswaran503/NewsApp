//
//  NewsFeedViewController.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var dataSource:[FeedDetails]!
    
    lazy var viewModel: NewsFeedViewModel = {
        let vm = NewsFeedViewModel()
        return vm
    }()

    //MARK: ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        self.navigationItem.setHidesBackButton(true, animated:true)
        // Do any additional setup after loading the view.
        
        viewModel.delegate = self
        viewModel.getNewsFeedData()
        tableViewSetup()
        addRefreshController()
        addNavBaritem()
    }
    
    func addNavBaritem() {
        let delete = UIBarButtonItem(image: #imageLiteral(resourceName: "deleteIcon"), style: .plain, target: self, action: #selector(delateAction(sender:))) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = delete
    }
    
    @objc func delateAction(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Are you sure want delete your account?", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
            CoreDataManager.shared.clearDatabase()
            
            let sigunUP = AppConstant.StoryBoardReference.main.instantiateViewController(withIdentifier: AppConstant.ViewControllerIdentifier.SignUpNC)
            UIApplication.shared.keyWindow?.rootViewController = sigunUP
            
            
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func tableViewSetup(){
        newsFeedTableView.dataSource = self
         newsFeedTableView.register(UINib(nibName: "\(NewsFeedCell.self)", bundle: Bundle.main), forCellReuseIdentifier: NewsFeedCell.cellID)
        newsFeedTableView.tableFooterView = UIView()
    }
    
    
    //MARK: Pull To Refresh Methods
    func addRefreshController() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(refreshControl:)), for: UIControl.Event.valueChanged)
        newsFeedTableView.addSubview(refreshControl)
    }
    @objc func refresh(refreshControl:UIRefreshControl) {
        // Code to refresh table view
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            refreshControl.endRefreshing()
        }
       viewModel.getNewsFeedData(fromRefresh: true)
       
        
    }
}

//MARK: TableView Protocols
extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataSource else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.cellID, for: indexPath) as? NewsFeedCell else { return UITableViewCell() }
        cell.setNewsFeedData(details: dataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}

//MARK: ViewModel Delegate Methods
extension NewsFeedViewController: NewsFeedViewModelDelegate {
    func successResponse(response: NewsFeedResponse) {
        DispatchQueue.main.async {
            if let _ = self.dataSource {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.refreshControl.endRefreshing()
                }
                self.dataSource = nil
            }
            self.dataSource = response.payload
            self.newsFeedTableView.reloadData()
        }
    }
    
    func alertMessage(message: String) {
        DispatchQueue.main.async {
            self.showAlert(for: message)
        }
    }
    
    
}
