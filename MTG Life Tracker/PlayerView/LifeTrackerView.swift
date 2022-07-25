//
//  LifeTrackerView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit
import Foundation

class LifeTrackerView: UIView {
    let kCONTENT_XIB_NAME = "LifeTrackerView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var pannableView: UIView!
    
    var rotation: UIInterfaceOrientation = .portrait

    private var initialCenter: CGPoint = .zero

    @IBOutlet weak var lifeTotalLabel: UILabel!
    
    @IBOutlet var topButton: UIButton!
    @IBOutlet var bottomButton: UIButton!

    
    var lifeTotal: Int = 40 {
        didSet {
            lifeTotalLabel.text = String(lifeTotal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 15
        
        pannableView.clipsToBounds = true
        pannableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        pannableView.layer.cornerRadius = 15
        
        topButton.alpha = 0.1
        bottomButton.alpha = 0.1
        
        pannableView.center = self.center
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        pannableView.addGestureRecognizer(panGestureRecognizer)

    }
    
    @IBAction func lifeTotalUpActions() {
        topButton.alpha = 1.0
        lifeTotal += 1
        UIView.animate(withDuration: 0.2) { [self] in
            topButton.alpha = 0.1
        }
    }
    
    @IBAction func lifeTotalDownActions() {
        bottomButton.alpha = 1.0
        lifeTotal -= 1
        UIView.animate(withDuration: 0.2) { [self] in
            bottomButton.alpha = 0.1
        }
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialCenter = pannableView.center
        case .changed:
            let translation = sender.translation(in: self.contentView)
            
            if initialCenter.y + translation.y < contentView.center.y {
                return
            }
            
            pannableView.center = CGPoint(x: initialCenter.x,
                                          y: initialCenter.y + translation.y)
        case .ended, .cancelled:
            let translation = sender.translation(in: self.contentView)

            if translation.y > initialCenter.y {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [self] in
                    let leftOverAmount = pannableView.frame.height * 0.8
                    let rect = CGRect.init(x: contentView.frame.origin.x, y: leftOverAmount, width: contentView.frame.width, height: contentView.frame.height)
                    pannableView.frame = rect
                }
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [self] in
                    pannableView.center = contentView.center
                }
            }
        default:
            break
        }
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
