//
//  GameOptionViewProvider.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/31/22.
//

import Foundation
import UIKit

enum GameOptionViewProvider {
    static func showDiceView(container: UIView?) -> DiceView {
        let diceView = DiceView()
        diceView.frame = container!.frame
        container!.addSubview(diceView)
        return diceView
    }

    static func showPlayerSelectorView(container: UIView?) -> PlayerSelectorView {
        let playerSelector = PlayerSelectorView()
        playerSelector.frame = container!.frame
        container!.addSubview(playerSelector)
        return playerSelector
    }
}
