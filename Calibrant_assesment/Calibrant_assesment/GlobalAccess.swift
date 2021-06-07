//
//  GlobalAccess.swift
//  Calibrant_assesment
//
//  Created by Rajesh on 05/06/21.
//

import UIKit

class GlobalAccess {
    
    class func removeTags(summary: String?) -> String {
        
        let description = summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return description ?? "no description available"
    }
}
