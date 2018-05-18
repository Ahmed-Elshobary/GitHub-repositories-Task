//
//  RepoDetailsViewController.swift
//  GitHubTask
//
//  Created by ahmed el shobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit

class RepoDetailsViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var numberOfSubscribersLabel: UILabel!
    @IBOutlet weak var listOfSubscribersLabel: UILabel!
    @IBOutlet weak var subscribersTableView: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    //MARK:- Variables
    
    var repoItem = RepoModel()
    var requestURL: String = ""
    var subscribersArray = [SubscribersModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        requestSubscribers()
    }
    
    //MARK:- Actions
    
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Setup Init Views
    
    func setupViews(){
        
        titleLabel.text = repoItem.repoName
        repoNameLabel.text = repoItem.repoName
        if let imageurl = URL(string: repoItem.repoOwner.ownerImage){
            ownerAvatarImageView.hnk_setImageFromURL(imageurl)
        }
        
        setupLocalization()
        
    }
    
    //MARK:- Localization
    
    func setupLocalization(){
    
        listOfSubscribersLabel.text = "Subscribers".localized
         noResultsLabel.text = "No Results".localized
    }
    
    func requestSubscribers(){
        
        Utilities.showLoader(view: self.view)
        requestURL = repoItem.repoSubscripURL
        AlamofireManager.sharedInstance.delegate = self
        AlamofireManager.sharedInstance.requestURL(reqURL: requestURL)
        
    }
}

extension RepoDetailsViewController : AlamofireManagerDelegate{
    
    func requestSuccessWithResponse(responseJSON: Any){
        let responsArray = responseJSON as! NSArray
        Utilities.hideLoader(view: self.view)
        for item in responsArray{
            let repoObject = SubscribersModel()
            repoObject.parseRepoModel(jsonDic: item as! [String:Any])
            self.subscribersArray.append(repoObject)
        }
        if subscribersArray.count > 0 {
            numberOfSubscribersLabel.text = "#Of Subscribers: " + "\(subscribersArray.count)"
            noResultsLabel.isHidden = true
            subscribersTableView.isHidden = false
            
        }else{
            numberOfSubscribersLabel.text = "#Of Subscribers: " + "\(subscribersArray.count)"
            noResultsLabel.isHidden = false
            subscribersTableView.isHidden = true
        }
        subscribersTableView.reloadData()
    }
    func requestFailedWithMessage(message: String){
        
        Utilities.hideLoader(view: self.view)
        showAlertViewWithTitle(title: "Error", msg: message, cancelBtnTitle: "ok")
        
    }
    func requestFailedWithError(error: String){
        
        Utilities.hideLoader(view: self.view)
        showAlertViewWithTitle(title: "Error", msg: error, cancelBtnTitle: "ok")
        
    }
}

extension RepoDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscribersArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVC = tableView.dequeueReusableCell(withIdentifier: "SubscribersCustomCellID", for: indexPath) as! SubscribersCustomCell
        
        let subItem = subscribersArray[indexPath.row]
        cellVC.setContentForCell(subscriberName: subItem.SubscName, subscriberImage: subItem.SubscAvatarURL)
        
        return cellVC
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
