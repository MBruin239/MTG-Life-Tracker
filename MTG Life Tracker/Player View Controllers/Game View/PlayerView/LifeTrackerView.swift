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

    @IBOutlet weak var lifeTotalLabel: CustomLabel!
    
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
        
        lifeTotalLabel.adjustsFontForContentSizeCategory = true
                
        let longPressTop = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        longPressTop.minimumPressDuration = 0.2
        self.topButton.addGestureRecognizer(longPressTop)
        
        let longPressBottom = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        longPressBottom.minimumPressDuration = 0.2
        self.bottomButton.addGestureRecognizer(longPressBottom)
    }
    
    @objc func increaseLife() {
        lifeTotal += 1
    }
    
    @objc func decreaseLife() {
        lifeTotal -= 1
    }
    
    @IBAction func lifeTotalUpActions() {
        increaseLife()
    }
    
    @IBAction func lifeTotalDownActions() {
        decreaseLife()
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
            break
        default:
            break
        }
    }
    
    func setFont(with descrpitor: UIFontDescriptor) {
        let size = lifeTotalLabel.font.pointSize
        
        lifeTotalLabel.font = UIFont.init(descriptor: descrpitor, size: size)
        lifeTotalLabel.fixLabelSize(true)
        lifeTotalLabel.fitFontForSize(minFontSize: 10.0, maxFontSize: 200.0, accuracy: 1.0)
    }
    
    func setTextColor(color: UIColor) {
        lifeTotalLabel.textColor = color
        bottomImage.tintColor = color
    }
}
