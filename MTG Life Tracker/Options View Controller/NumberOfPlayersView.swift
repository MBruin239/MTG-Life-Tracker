//
//  NumberOfPlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/24/22.
//

import UIKit

protocol NumberOfPlayersViewDelegate {
    func setNumberOfPlayers(playerCount: PlayerCount)
}

class NumberOfPlayersView: UIView {
    let kCONTENT_XIB_NAME = "NumberOfPlayersView"
    
    var delegate: NumberOfPlayersViewDelegate?
    
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    @IBOutlet var fiveButton: UIButton!
    @IBOutlet var sixButton: UIButton!
    
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
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    @IBAction func twoButtonPress() {
        delegate?.setNumberOfPlayers(playerCount: .two)
    }
    
    @IBAction func threeButtonPress() {
        delegate?.setNumberOfPlayers(playerCount: .three)
    }
    
    @IBAction func fourButtonPress() {
        delegate?.setNumberOfPlayers(playerCount: .four)
    }
    
    @IBAction func fiveButtonPress() {
        delegate?.setNumberOfPlayers(playerCount: .five)
    }
    
    @IBAction func sixButtonPress() {
        delegate?.setNumberOfPlayers(playerCount: .six)
    }
}
