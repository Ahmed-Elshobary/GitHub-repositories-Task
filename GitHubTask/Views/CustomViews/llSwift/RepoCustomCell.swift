//
//  RepoCustomCell.swift
//  GitHubTask
//
//  Created by ahmed el shobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit
import Haneke
class RepoCustomCell: UITableViewCell {

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var numberOfForks: UILabel!
    @IBOutlet weak var repoDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContentForCell(repoImageS:String, repoNameS:String, numOfForksI:Int, repoDescS:String){
        
        repoName.text = repoNameS
        numberOfForks.text = "#Of Forks: " + "\(numOfForksI)"
        repoDesc.text = repoDescS
        
        if let imageurl = URL(string: repoImageS){
            repoImage.hnk_setImageFromURL(imageurl)
        }
    }
}
