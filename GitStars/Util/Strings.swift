//
//  Localizable.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 04/04/22.
//

import Foundation

enum String {
    case ascendingText
    case descendingText
    
    
    
}

extension String {
    
    init(localizable: String) {
        self = NSLocalizedString(localizable, comment: "")
    }
    
}
