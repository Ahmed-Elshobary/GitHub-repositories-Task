//
//  String+Localization.swift
//  Naqliat
//
//  Created by ahmed elshobary on 18/05/18.
//  Copyright © 2018 ahmed elshobary. All rights reserved.
//

import Foundation
extension String {
    
    var localized: String {
        return NSLocalizedString(self, bundle: .main, comment: "")
        
    }
}
