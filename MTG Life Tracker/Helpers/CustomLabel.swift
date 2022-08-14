//
//  CustomLabel.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 8/14/22.
//

import UIKit

class CustomLabel: UILabel {
    
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?

}


extension CustomLabel {
    
    func fixLabelSize(_ fixed: Bool) {
        if fixed {
            widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.width)
            heightConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.height)
            NSLayoutConstraint.activate([widthConstraint!, heightConstraint!])
        } else {
            NSLayoutConstraint.deactivate([widthConstraint!, heightConstraint!])
        }
    }

    func fitFontForSize(minFontSize: CGFloat, maxFontSize: CGFloat, accuracy: CGFloat) {
        assert(maxFontSize > minFontSize)
        let constrainedSize = bounds.size
        var min = minFontSize
        var max = maxFontSize
        while max - min > accuracy {
            let midFontSize : CGFloat = ((min + max) / 2)
            font = font.withSize(midFontSize)
            sizeToFit()
            let checkSize : CGSize = bounds.size
            if  checkSize.height < constrainedSize.height && checkSize.width < constrainedSize.width {
                min = midFontSize
            } else {
                max = midFontSize
            }
        }
        font = font.withSize(min)
        sizeToFit()
    }

}
