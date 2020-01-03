//
//  DefaultWrapper.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import Foundation

class DefaultWrapper: NSObject {
    
    func isSubscribed() -> Bool{
        let status = UserDefaults.standard.bool(forKey: "subscribed")
        return status
    }
    
    //MARK: Save
    func subscribed(_ status: Bool){
        let defaults = UserDefaults.standard
        defaults.set(status, forKey: "subscribed")
    }
    
}
