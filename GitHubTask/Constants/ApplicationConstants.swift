//
//  ApplicationConstants.swift
//  Naqliat
//
//  Created by ahmed elshobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import Foundation
import UIKit

func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
 func showAlertViewWithTitle(title:String , msg:String, cancelBtnTitle: String) {
    let alert = UIAlertView()
    alert.message = msg
    alert.title = title
    alert.message = msg
    alert.addButton(withTitle: cancelBtnTitle)
    alert.show()
}

let langStr = Locale.current.languageCode!
let LIGHTER_BROWN = 0xffbb00
let ALPHA_COMPONENT: CGFloat = 0.6
let LOADER_WIDTH: CGFloat = 50.0

let API_URL = "https://api.github.com/"
let SEARCH_REPO = "search/repositories?q="
