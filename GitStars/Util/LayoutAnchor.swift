//
//  LayoutAnchor.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 31/03/22.
//

import UIKit

enum LayoutAnchor {
    case constant(attribute: NSLayoutConstraint.Attribute,
                  relation: NSLayoutConstraint.Relation,
                  constant: CGFloat)
    
    case relative(attribute: NSLayoutConstraint.Attribute,
                  relation: NSLayoutConstraint.Relation,
                  relatedTo: NSLayoutConstraint.Attribute,
                  multiplier: CGFloat,
                  constant: CGFloat)
    
    
}

extension LayoutAnchor {
    static let leading = relative(attribute: .leading, relation: .equal, relatedTo: .leading)
    static let trailing = relative(attribute: .trailing, relation: .equal, relatedTo: .leading)
    static let top = relative(attribute: .top, relation: .equal, relatedTo: .top)
    static let bottom = relative(attribute: .bottom, relation: .equal, relatedTo: .bottom)
    static let width = constant(attribute: .width, relation: .equal)
    static let height = constant(attribute: .height, relation: .equal)

    static func constant (
        attribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation
    ) -> (CGFloat) -> LayoutAnchor {
        return { constant in
                .constant(attribute: attribute, relation: relation, constant: constant)
        }
    }
    
    static func relative (
        attribute: NSLayoutConstraint.Attribute,
        relation: NSLayoutConstraint.Relation,
        relatedTo: NSLayoutConstraint.Attribute,
        multiplier: CGFloat = 1
    ) -> (CGFloat) -> LayoutAnchor {
        return { constant in
                .relative(attribute: attribute, relation: relation, relatedTo: relatedTo, multiplier: multiplier, constant: constant)
        }
    }
    
    
}
