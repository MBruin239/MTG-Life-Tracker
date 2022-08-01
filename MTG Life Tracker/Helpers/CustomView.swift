//
//  CustomView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

class CustomView: UIView {
        
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        
    }
    
    func addBlurEffect(alpha: Double){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = alpha
        self.insertSubview(blurEffectView, belowSubview: self.contentView)
    }
}

extension UIView
{
    func fixInView(_ container: UIView!){
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func rotateViewInView(_ container: UIView!, rotation: Double) {
        self.frame = container.frame.flipped
        self.transform = self.transform.rotated(by: rotation);
        container.addSubview(self);
    }
    
    func transitionInFromRight(container: UIView!, oldView: UIView, removeOld: Bool){
        self.frame = CGRect.init(x: 2*container.frame.width, y: 0, width: container.frame.width, height: container.frame.height)
        container.addSubview(self)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: { [self] in
            oldView.center = CGPoint.init(x: -1*oldView.frame.width, y: oldView.center.y)
            self.center = container.center
        }, completion: {_ in
            if removeOld {
                oldView.removeFromSuperview()
            }
        })
    }
    
    func transitionInFromLeft(container: UIView!, oldView: UIView, removeOld: Bool){
        self.frame = CGRect.init(x: -1*container.frame.width, y: 0, width: container.frame.width, height: container.frame.height)
        container.addSubview(self)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: { [self] in
            oldView.center = CGPoint.init(x: 2*oldView.frame.width, y: oldView.center.y)
            self.center = container.center
        }, completion: {_ in
            if removeOld {
                oldView.removeFromSuperview()
            }
        })
    }
}

extension CGRect {
    public var flipped: CGRect {
        let xOffset = (width - height) / 2.0
        let yOffset = (height - width) / 2.0
        
        return CGRect(x: xOffset, y: yOffset, width: self.size.height, height: self.size.width)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
