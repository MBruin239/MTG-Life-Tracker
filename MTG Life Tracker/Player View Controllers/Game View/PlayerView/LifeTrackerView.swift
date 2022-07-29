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

    @IBOutlet weak var lifeTotalLabel: UILabel!
    
    @IBOutlet var topButton: UIButton!
    @IBOutlet var bottomButton: UIButton!
    var longPressTimer: Timer?
    
    @IBOutlet var bottomImage: UIImageView!
    var counterType: CounterType = .life

    var lifeTotal: Int = 40 {
        didSet {
            lifeTotalLabel.text = String(lifeTotal)
        }
    }
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        topButton.alpha = 0.1
        bottomButton.alpha = 0.1
        
        let longPressTop = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        longPressTop.minimumPressDuration = 0.2
        self.topButton.addGestureRecognizer(longPressTop)
        
        let longPressBottom = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        longPressBottom.minimumPressDuration = 0.2
        self.bottomButton.addGestureRecognizer(longPressBottom)
    }
    
    @objc func increaseLife() {
        topButton.alpha = 1.0
        lifeTotal += 1
    }
    
    @objc func decreaseLife() {
        bottomButton.alpha = 1.0
        lifeTotal -= 1
    }
    
    @IBAction func lifeTotalUpActions() {
        increaseLife()
        UIView.animate(withDuration: 0.2) { [self] in
            topButton.alpha = 0.1
        }
    }
    
    @IBAction func lifeTotalDownActions() {
        decreaseLife()
        UIView.animate(withDuration: 0.2) { [self] in
            bottomButton.alpha = 0.1
        }
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            if sender.view == topButton {
                longPressTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(increaseLife), userInfo: nil, repeats: true)
            } else {
                longPressTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(decreaseLife), userInfo: nil, repeats: true)
            }
            break
        case .ended, .cancelled:
            longPressTimer?.invalidate()
            UIView.animate(withDuration: 0.2) { [self] in
                topButton.alpha = 0.1
                bottomButton.alpha = 0.1
            }
            break
        default:
            break
        }
    }
}
