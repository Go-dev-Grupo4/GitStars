//
//  File.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 02/04/22.
//

import UIKit

enum ViewState {
    
    case loading
    case normal
    case error
    
}

protocol TriStateViewProtocol {
            
    func setupLoadingState()
    func setupErrorState()
    func setupNormalState()
    
}
