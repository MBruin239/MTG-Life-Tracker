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
}

extension CGRect {
    public var flipped: CGRect {
        let xOffset = (width - height) / 2.0
        let yOffset = (height - width) / 2.0
        
        return CGRect(x: xOffset, y: yOffset, width: self.size.height, height: self.size.width)
    }
}
