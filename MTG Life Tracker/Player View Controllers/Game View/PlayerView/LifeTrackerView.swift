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
}
