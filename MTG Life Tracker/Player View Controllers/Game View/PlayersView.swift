//
//  PlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

protocol PlayersViewDelegate {
    func menuButtonPress()
    func resetGameToStart()
    func openCounterSelectorView(counterSelectorView: CountersSelectorView)
}

class PlayersView: CustomView {
    var startingLifeTotal: Int = 40
    
    var delegate: PlayersViewDelegate?
    
    var optionsView: GameOptionsView = GameOptionsView()
    
    func setup() {
        optionsView.delegate = self
    }
    
    func openGameOptionsView(){
        optionsView.frame = self.frame
        self.addSubview(optionsView)
    }
    
    @IBAction func menuButtonPress() {
        openGameOptionsView()
    }
}

extension PlayersView: PlayerViewDelegate {
    func openCounterSelectorView(counterSelectorView: CountersSelectorView) {
        delegate?.openCounterSelectorView(counterSelectorView: counterSelectorView)
    }
}

extension PlayersView: GameOptionsViewDelegate {
    func resetGameToStart() {
        delegate?.resetGameToStart()
    }
    
    func returnToMainMenu() {
        delegate?.menuButtonPress()
    }
}
