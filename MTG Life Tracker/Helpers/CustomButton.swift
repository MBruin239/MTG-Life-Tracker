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
