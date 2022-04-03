//
//  UIView+extensions.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 31/03/22.
//

import UIKit

extension UIView {
 
    enum SuperviewAreaReference {
        case safeArea
        case viewArea
    }
    
    func topAnchorToTopAnchor(_ constant: CGFloat) -> UIView {
        
        let constraint = NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1, constant: constant)
        
        constraint.isActive = true
        
        return self
    }
    
    func bottomAnchorToBottomAnchor(_ constant: CGFloat) -> UIView {
        
        let constraint = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1, constant: constant)
        
        constraint.isActive = true
        
        return self
    }
    
    func leadingAnchorToLeadingAnchor(_ constant: CGFloat) -> UIView {
        
        let constraint = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1, constant: constant)
        
        constraint.isActive = true
        
        return self
    }
    
    func trailingAnchorToTrailingAnchor(_ constant: CGFloat) -> UIView {
        
        let constraint = NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: self.superview, attribute: .trailing, multiplier: 1, constant: constant)
        
        constraint.isActive = true
        
        return self
    }
    
    func anchored(_ anchor1: NSLayoutConstraint.Attribute, to anchor2: NSLayoutConstraint.Attribute, by constant: CGFloat = 0) -> UIView {
        let constraint = NSLayoutConstraint.init(item: self, attribute: anchor1, relatedBy: .equal, toItem: self.superview, attribute: anchor2, multiplier: 1, constant: constant)
        
        constraint.isActive = true
        
        return self
    }
    
    func attach(_ anchor1: NSLayoutConstraint.Attribute, to anchor2: NSLayoutConstraint.Attribute, of view: UIView? = nil, by constant: CGFloat = 0) -> UIView {
        let constraint = NSLayoutConstraint.init(item: self, attribute: anchor1, relatedBy: .equal, toItem: view ?? self.superview, attribute: anchor2, multiplier: 1, constant: constant)
        
        constraint.isActive = true
        
        return self
    }
    
    func end() {}
    
    func sizeUpToFillSuperview() {
        
        self.topAnchorToTopAnchor(0)
            .leadingAnchorToLeadingAnchor(0)
            .bottomAnchorToBottomAnchor(0)
            .trailingAnchorToTrailingAnchor(0)
            .end()
       
    }
    
}

