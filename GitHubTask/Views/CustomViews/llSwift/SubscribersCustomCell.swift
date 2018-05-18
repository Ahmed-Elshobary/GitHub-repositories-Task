//
//  SubscribersCustomCell.swift
//  GitHubTask
//
//  Created by ahmed el shobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit

class SubscribersCustomCell: UITableViewCell {

    @IBOutlet weak var subImage: UIImageView!
    @IBOutlet weak var subName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setContentForCell(subscriberName:String, subscriberImage:String){
        
        subName.text = subscriberName

        if let imageurl = URL(string: subscriberImage){
            subImage.hnk_setImageFromURL(imageurl)
        }
    }
}
