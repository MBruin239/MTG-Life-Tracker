//
//  PlayerSelectorView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

class PlayerSelectorView: CustomView {
    let kCONTENT_XIB_NAME = "PlayerSelectorView"
    
    var circleView: CircleView?


    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        longPressRecognizer.minimumPressDuration = 0.1
        longPressRecognizer.delaysTouchesBegan = true
        longPressRecognizer.delegate = self
        self.addGestureRecognizer(longPressRecognizer)
        
    }
    
    @objc private func longPressed(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            let initialCenter = sender.location(in: contentView)
            
            circleView = CircleView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
            circleView?.center = initialCenter
            circleView?.initialCenter = initialCenter
            
            contentView.addSubview(circleView!)
        case .changed:
            circleView!.center = sender.location(in: contentView)
            break
        case .ended, .cancelled:
            circleView?.removeFromSuperview()
            break
        default:
            break
        }
    }

}

extension PlayerSelectorView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}
