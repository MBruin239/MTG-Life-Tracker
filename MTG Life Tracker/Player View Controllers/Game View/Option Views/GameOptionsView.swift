//
//  GameOptionsView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/29/22.
//

import UIKit

protocol GameOptionsViewDelegate {
    func returnToMainMenu()
    func resetGameToStart()
}

class GameOptionsView: CustomView {
    let kCONTENT_XIB_NAME = "GameOptionsView"
    
    var delegate: GameOptionsViewDelegate?
    
    @IBOutlet var closeButton: CustomButton!
    @IBOutlet var resetButton: CustomButton!
    @IBOutlet var selectorButton: CustomButton!
    @IBOutlet var diceButton: CustomButton!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        closeButton.contentHorizontalAlignment = .fill
        closeButton.contentVerticalAlignment = .fill
        
        resetButton.centerVertically()
        diceButton.centerVertically()
        selectorButton.centerVertically()

    }
    
    @IBAction func closeButtonPress() {
        self.removeFromSuperview()
    }
    
    @IBAction func mainMenuButtonPress() {
        delegate?.returnToMainMenu()
    }
    
    @IBAction func resetButtonPress() {
        delegate?.resetGameToStart()
    }
    
    @IBAction func selectorButtonPress() {
        let selectorView = GameOptionViewProvider.showPlayerSelectorView(container: self)
        self.addSubview(selectorView)
        
    }
    
    @IBAction func diceButtonPress() {
        let diceView = GameOptionViewProvider.showDiceView(container: self)
        self.addSubview(diceView)
    }
}
