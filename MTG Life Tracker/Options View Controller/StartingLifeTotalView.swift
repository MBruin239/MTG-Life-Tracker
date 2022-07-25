//
//  StartingLifeTotalView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/24/22.
//

import UIKit

protocol StartingLifeTotalViewDelegate {
    func setStartingLifeTotal(lifeTotal: Int)
}

class StartingLifeTotalView: UIView {
    let kCONTENT_XIB_NAME = "StartingLifeTotalView"
    
    var delegate: StartingLifeTotalViewDelegate?
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var twentyButton: UIButton!
    @IBOutlet var thirtyButton: UIButton!
    @IBOutlet var fourtyButton: UIButton!

    
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
    }
    
    @IBAction func twentyButtonPress() {
        delegate?.setStartingLifeTotal(lifeTotal: 20)
    }
    
    @IBAction func thirtyButtonPress() {
        delegate?.setStartingLifeTotal(lifeTotal: 30)
    }
    
    @IBAction func fortyButtonPress() {
        delegate?.setStartingLifeTotal(lifeTotal: 40)
    }
}
