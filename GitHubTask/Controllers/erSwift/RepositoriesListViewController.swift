//
//  RepositoriesListViewController.swift
//  GitHubTask
//
//  Created by ahmed el shobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit

class RepositoriesListViewController: UIViewController {

    //MARK:- Outelts
    
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    
    //MARK:- Variables
    
    var requestURL: String = API_URL + SEARCH_REPO
    var repoArray = [RepoModel]()
    
    //MARK:- Actions
    
    @IBAction func searchButtonAction(_ sender: Any) {
        
        if searchTextField.text != ""{
            
            requestRepositories(searchText: searchTextField.text!)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
     //MARK:- Setup Init Views
    
    func setupViews(){
        
        resultTableView.isHidden = true
        setupLocalization()
        
    }
    
    //MARK:- Localization
    
    func setupLocalization(){
        
        titleLabel.text =  "list of repositories".localized
        noResultsLabel.text = "No Results".localized
        searchButtonOutlet.setTitle("Search".localized, for: .normal)
    }
    
    func requestRepositories(searchText:String){
        
        Utilities.showLoader(view: self.view)
        requestURL = requestURL + searchText
        AlamofireManager.sharedInstance.delegate = self
        AlamofireManager.sharedInstance.requestURL(reqURL: requestURL)
        
    }
}

extension RepositoriesListViewController : AlamofireManagerDelegate{
    
    func requestSuccessWithResponse(responseJSON: Any){
        
        Utilities.hideLoader(view: self.view)
        let responseDic = responseJSON as! NSDictionary
        let itemsArray = responseDic.value(forKey: "items") as! NSArray
        for item in itemsArray{
            let repoObject = RepoModel()
            repoObject.parseRepoModel(jsonDic: item as! [String:Any])
            self.repoArray.append(repoObject)
        }
        if repoArray.count > 0 {
            noResultsLabel.isHidden = true
            resultTableView.isHidden = false
        }
        searchTextField.text = ""
        resultTableView.reloadData()
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

extension RepositoriesListViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVC = tableView.dequeueReusableCell(withIdentifier: "RepoCustomCellID", for: indexPath) as! RepoCustomCell
        
        let repoItem = repoArray[indexPath.row]
        cellVC.setContentForCell(repoImageS: repoItem.repoOwner.ownerImage, repoNameS: repoItem.repoName, numOfForksI: repoItem.repoforks, repoDescS: repoItem.repoDesc)
        
        return cellVC
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RepoDetailsViewControllerID") as! RepoDetailsViewController
        vc.repoItem = repoArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
}
