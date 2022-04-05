//
//  Coordinator.swift
//  GitStars
//
//  Created by Matheus Lenke on 05/04/22.
//

import Foundation

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get }
    
    func start()
}
