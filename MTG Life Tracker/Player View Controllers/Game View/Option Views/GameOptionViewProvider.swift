//
//  GameOptionViewProvider.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/31/22.
//

import Foundation
import UIKit

enum GameOptionViewProvider {
    static func showDiceView(container: UIView?, delegate: DiceViewDelegate) -> DiceView {
        let diceView = DiceView()
        diceView.delegate = delegate
        diceView.frame = container!.frame
        container!.addSubview(diceView)
        return diceView
    }

    static func showPlayerSelectorView(container: UIView?, numberOfPlayers: PlayerCount, delegate: PlayerSelectorViewDelegate) -> PlayerSelectorView {
        let playerSelector = PlayerSelectorView()
        playerSelector.frame = container!.frame
        container!.addSubview(playerSelector)
        playerSelector.expectedNumberOfPlayers = numberOfPlayers
        playerSelector.delegate = delegate
        return playerSelector
    }
}
