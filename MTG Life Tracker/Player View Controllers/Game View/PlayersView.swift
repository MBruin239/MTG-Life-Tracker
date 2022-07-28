//
//  PlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

protocol PlayersViewDelegate {
    func menuButtonPress()
    func openCounterSelectorView(counterSelectorView: CountersSelectorView)
}

class PlayersView: CustomView {
    var startingLifeTotal: Int = 40
    
    var delegate: PlayersViewDelegate?
    
    func setup() {

    }
    
    @IBAction func menuButtonPress() {
        delegate?.menuButtonPress()
    }
}

extension PlayersView: PlayerViewDelegate {
    func openCounterSelectorView(counterSelectorView: CountersSelectorView) {
        delegate?.openCounterSelectorView(counterSelectorView: counterSelectorView)
    }
}
