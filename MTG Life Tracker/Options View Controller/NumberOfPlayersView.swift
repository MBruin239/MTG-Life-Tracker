//
//  NumberOfPlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/24/22.
//

import UIKit

enum PlayerCount: Int {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
}

protocol NumberOfPlayersViewDelegate {
    func numberOfPlayersViewBackButtonPress()
    func setNumberOfPlayers(playerCount: PlayerCount)
}

class NumberOfPlayersView: CustomView {
    let kCONTENT_XIB_NAME = "NumberOfPlayersView"
    
    var delegate: NumberOfPlayersViewDelegate?
    
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    @IBOutlet var fiveButton: UIButton!
    @IBOutlet var sixButton: UIButton!
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    @IBAction func backButtonPress() {
        delegate?.numberOfPlayersViewBackButtonPress()
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
