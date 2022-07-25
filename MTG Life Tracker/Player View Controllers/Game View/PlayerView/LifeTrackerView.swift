//
//  LifeTrackerView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit
import Foundation

class LifeTrackerView: CustomView {
    let kCONTENT_XIB_NAME = "LifeTrackerView"
    
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
    
    override func commonInit() {
        super.commonInit()
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
