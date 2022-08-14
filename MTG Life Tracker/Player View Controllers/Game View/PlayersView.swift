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
    func openFontPickerView(fontPickerView: UIFontPickerViewController)
}

class PlayersView: CustomView {
    var startingLifeTotal: Int = 40
    var numberOfPlayers: PlayerCount = .two
    var playersViewsArray: [PlayerView] = []
    
    var delegate: PlayersViewDelegate?
    
    @IBOutlet var menuButton: CustomButton!
    
    var optionsView: GameOptionsView = GameOptionsView()
    
    func setup() {
        optionsView.delegate = self
        
        menuButton.cornerRadius = 22.5
        menuButton.contentHorizontalAlignment = .fill
        menuButton.contentVerticalAlignment = .fill
    }
    
    private func resetGameToTheStart() {
        for playerView in playersViewsArray {
            playerView.resetGame(with: startingLifeTotal)
        }
    }
    
    func openGameOptionsView(){
        optionsView.frame = self.frame
        optionsView.numberOfPlayers = numberOfPlayers
        self.addSubview(optionsView)
    }
    
    @IBAction func menuButtonPress() {
        openGameOptionsView()
    }
}

extension PlayersView: PlayerViewDelegate {
    func openFontPickerView(fontPickerView: UIFontPickerViewController) {
        delegate?.openFontPickerView(fontPickerView: fontPickerView)
    }
    
    func openCounterSelectorView(counterSelectorView: CountersSelectorView) {
        delegate?.openCounterSelectorView(counterSelectorView: counterSelectorView)
    }
}

extension PlayersView: GameOptionsViewDelegate {
    func resetGameToStart() {
        resetGameToTheStart()
    }
    
    func returnToMainMenu() {
        delegate?.menuButtonPress()
    }
}
