//
//  CustomButton.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/27/22.
//

import UIKit

class CustomButton: UIButton {
    var cornerRadius: CGFloat = 0 {
        didSet {
           self.layer.cornerRadius = cornerRadius
        }
    }
    
    var counterType: CounterType = .star
    
    func setupCounterButton(counterType: CounterType) {
        self.counterType = counterType
        
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        self.cornerRadius = 10.0
    }
}

extension CustomButton {
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}
