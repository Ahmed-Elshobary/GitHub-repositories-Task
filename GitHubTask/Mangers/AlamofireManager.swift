//
//  AlamofireManager.swift
//  Variety
//
//  Created by Ahmed elshobary on 11/13/16.
//  Copyright © 2018 ahmed el shobary. All rights reserved.
//

import UIKit
import Alamofire

protocol AlamofireManagerDelegate {
    func requestSuccessWithResponse(responseJSON: Any)
    func requestFailedWithMessage(message: String)
    func requestFailedWithError(error: String)
}

class AlamofireManager: NSObject {
    
    var delegate: AlamofireManagerDelegate?
    
    // MARK: - Singleton Initialization -
    
    static let sharedInstance: AlamofireManager = { AlamofireManager() }()
    
    // MARK: - Request with Parameters -
    
    func requestURL(reqURL: String) {
        
        print("URL \(reqURL)")
        Alamofire.request(reqURL)
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    let status = response.result.value as Any
                    self.delegate?.requestSuccessWithResponse(responseJSON: status as Any)
                    break
                case .failure(let error):
                    print(error)
                    print("ERROR \(error.localizedDescription))")
                    
                    self.delegate!.requestFailedWithError(error: error.localizedDescription)
                    break
                }
        }
        
    }

}
