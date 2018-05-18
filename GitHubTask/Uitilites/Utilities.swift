//
//  Utilities.swift
//  MFP
//
//  Created by Ahmed Elshobary on 5/18/18.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Utilities: NSObject {
    
    // MARK: - Show/Hide Loader -

    class func showLoader(view:UIView) {
        view.isUserInteractionEnabled = false
        let dimmedView = UIView(frame: view.frame)
        dimmedView.backgroundColor = UIColor.black.withAlphaComponent(ALPHA_COMPONENT)

        let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: view.frame.midX - LOADER_WIDTH / 2, y: view.frame.midY - LOADER_WIDTH / 2, width: LOADER_WIDTH, height: LOADER_WIDTH), color: UIColorFromRGB(LIGHTER_BROWN))
        dimmedView.addSubview(activityIndicatorView)
        view.addSubview(dimmedView)
        activityIndicatorView.startAnimating()
    }
    
    class func hideLoader(view:UIView) {
        view.isUserInteractionEnabled = true
        let v = view.subviews.last
        v?.removeFromSuperview()
    }
    
    // MARK: - Show Alert -
    
    class func showAlertControllerOverController(controller:UIViewController, withTitle:String?, message:String, action:[UIAlertAction]) {
        let alert = UIAlertController(title: withTitle, message: message,preferredStyle: UIAlertControllerStyle.alert)
        action.forEach { newAction in
            alert.addAction(newAction)
        }
        // Avoid presenting more than alert
        if controller.presentedViewController?.isKind(of:UIAlertController.self) == nil {
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    class func deviceLanguage() -> String {
        return NSLocale.preferredLanguages[0]
    }
    
    // MARK: - Creates a UIColor from a Hex string -
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
