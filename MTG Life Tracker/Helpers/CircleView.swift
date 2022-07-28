//
//  CircleView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

class CircleView: UIView {
    var initialCenter: CGPoint = .zero
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
        
       // let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
       // self.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialCenter = sender.location(in: superview)
        case .changed:
            let translation = sender.translation(in: superview)
            
            self.center = CGPoint(x: self.initialCenter.x + translation.x,
                                          y: self.initialCenter.y + translation.y)
        case .ended, .cancelled:
            break
        default:
            break
        }
    }
}
