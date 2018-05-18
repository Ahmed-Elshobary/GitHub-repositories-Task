//
//  RepoModel.swift
//  GitHubTask
//
//  Created by ahmed el shobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit

class RepoModel: NSObject {
    
    var repoid: Int = -1
    var repoName: String = ""
    var repoDesc: String = ""
    var repoOwner = OwnerModel()
    var repoforks: Int = 0
    var repoSubscripURL: String = ""
    
    func parseRepoModel(jsonDic : [String:Any]){
        let ownerObject = OwnerModel()
        repoid = jsonDic["id"] as? Int ?? 0
        repoName = jsonDic["full_name"] as? String ?? ""
        repoDesc = jsonDic["description"] as? String ?? ""
        repoOwner = ownerObject.setOwnerModel(ownerDic: jsonDic["owner"] as! [String:Any])
        repoforks = jsonDic["forks"] as? Int ?? 0
        repoSubscripURL = jsonDic["subscribers_url"] as? String ?? ""
    }

}

class OwnerModel: NSObject{
    
    var ownerID: Int = 0
    var ownerImage: String = ""
    
    func setOwnerModel(ownerDic : [String:Any]) -> OwnerModel{
        let onwerObjectM = OwnerModel()
        onwerObjectM.ownerID = ownerDic["id"] as? Int ?? 0
        onwerObjectM.ownerImage = ownerDic["avatar_url"] as? String ?? ""
        return onwerObjectM
    }
    
    
}
