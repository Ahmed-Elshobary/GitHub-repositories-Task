//
//  SubscribersModel.swift
//  GitHubTask
//
//  Created by ahmed el shobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit

class SubscribersModel: NSObject {
    
    var Subscid: Int = -1
    var SubscName: String = ""
    var SubscAvatarURL: String = ""
    
    func parseRepoModel(jsonDic : [String:Any]){
        Subscid = jsonDic["id"] as? Int ?? 0
        SubscName = jsonDic["login"] as? String ?? ""
        SubscAvatarURL = jsonDic["avatar_url"] as? String ?? ""
    }
}
