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
    
    var numberOfPlayers: PlayerCount = .two
    
    @IBOutlet var mainView: CustomView!
    var selectorView: PlayerSelectorView?
    var diceView: DiceView?
    
    @IBOutlet var menuButton: CustomButton!
    @IBOutlet var closeButton: CustomButton!
    @IBOutlet var resetButton: CustomButton!
    @IBOutlet var selectorButton: CustomButton!
    @IBOutlet var diceButton: CustomButton!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        menuButton.cornerRadius = 10
        
        closeButton.contentHorizontalAlignment = .fill
        closeButton.contentVerticalAlignment = .fill
        
        resetButton.centerVertically()
        diceButton.centerVertically()
        selectorButton.centerVertically()
        
        self.addBlurEffect(alpha: 0.9)
    }
    
    @IBAction func closeButtonPress() {
        self.removeFromSuperview()
    }
    
    @IBAction func mainMenuButtonPress() {
        delegate?.returnToMainMenu()
    }
    
    @IBAction func resetButtonPress() {
        delegate?.resetGameToStart()
        self.removeFromSuperview()
    }
    
    @IBAction func selectorButtonPress() {
        selectorView = GameOptionViewProvider.showPlayerSelectorView(container: self, numberOfPlayers: numberOfPlayers, delegate: self)
        selectorView?.transitionInFromRight(container: self.contentView, oldView: self.mainView, removeOld: false)
    }
    
    @IBAction func diceButtonPress() {
        diceView = GameOptionViewProvider.showDiceView(container: self, delegate: self)
        diceView?.transitionInFromRight(container: self.contentView, oldView: self.mainView, removeOld: false)
    }
}

extension GameOptionsView: PlayerSelectorViewDelegate {
    func playerWasSelected() {
        self.mainView.transitionInFromLeft(container: self.contentView, oldView: selectorView!, removeOld: true)
    }
}

extension GameOptionsView: DiceViewDelegate {
    func dismissView() {
        self.mainView.transitionInFromLeft(container: self.contentView, oldView: diceView!, removeOld: true)
    }
}
