//
//  PlayerSelectorView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

class PlayerSelectorView: CustomView {
    let kCONTENT_XIB_NAME = "PlayerSelectorView"
    
    var circleViews: [Int:CircleView] = [:]

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        self.isMultipleTouchEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        event?.allTouches?.forEach {
            print("touch began for: \($0.hash)")
            
            if let circleView = circleViews[$0.hashValue] {
                circleViews.updateValue(circleView, forKey: $0.hashValue)
            } else {
                let point = $0.location(in: self)

                let circleView = CircleView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
                circleView.center = point
                circleView.initialCenter = point
                        
                contentView.addSubview(circleView)
                circleViews.updateValue(circleView, forKey: $0.hashValue)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        event?.allTouches?.forEach {
            if let circleView = circleViews[$0.hashValue] {
                let point = $0.location(in: self)
                 circleView.center = point
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        event?.allTouches?.forEach {
            let point = $0.location(in: self)
            if let circleView = circleViews[$0.hashValue] {
                circleView.center = point
                circleView.removeFromSuperview()
                circleViews.removeValue(forKey: $0.hashValue)
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        event?.allTouches?.forEach {
            let point = $0.location(in: self)
            if let circleView = circleViews[$0.hashValue] {
                circleView.center = point
                circleView.removeFromSuperview()
                circleViews.removeValue(forKey: $0.hashValue)
            }
        }
    }
}
