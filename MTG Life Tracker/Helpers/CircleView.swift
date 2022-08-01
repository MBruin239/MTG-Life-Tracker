//
//  CircleView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

class CircleView: UIView {
    var lastCenter: CGPoint = .zero
    var index: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: self.bounds).cgPath;
        self.layer.mask = maskLayer
        self.backgroundColor = .random()
    }
    
    func changeFrame(frame: CGRect) {
        self.layer.mask?.removeFromSuperlayer()
        self.layer.frame = frame
        self.center = lastCenter
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: self.bounds).cgPath;
        self.layer.mask = maskLayer
    }
    
    func startAnimations() {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = 0.5
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: nil)
        
        let growAnimationX = CABasicAnimation(keyPath: "transform.scale.x")
        growAnimationX.duration = 1
        growAnimationX.fromValue = 1
        growAnimationX.toValue = 1.5
        growAnimationX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        growAnimationX.autoreverses = true
        growAnimationX.repeatCount = .greatestFiniteMagnitude
        self.layer.add(growAnimationX, forKey: nil)
        
        let growAnimationY = CABasicAnimation(keyPath: "transform.scale.y")
        growAnimationY.duration = 1
        growAnimationY.fromValue = 1
        growAnimationY.toValue = 1.5
        growAnimationY.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        growAnimationY.autoreverses = true
        growAnimationY.repeatCount = .greatestFiniteMagnitude
        self.layer.add(growAnimationY, forKey: nil)
    }
}
