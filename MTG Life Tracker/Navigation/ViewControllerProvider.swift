//
//  ViewControllerProvider.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import Foundation
import UIKit

enum PlayerCount {
    case two
    case three
    case four
    case five
    case six
}

enum ViewControllerProvider {
    static var optionsViewController: OptionsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController
        return viewController
    }

    static func startGameViewController(lifeTotal: Int, numPlayers: PlayerCount) -> PlayersViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var viewController: PlayersViewController

        switch numPlayers {
        case .two:
            viewController = storyboard.instantiateViewController(withIdentifier: "TwoPlayersViewController") as! TwoPlayersViewController
            break
        case .three:
            viewController = storyboard.instantiateViewController(withIdentifier: "ThreePlayersViewController") as! ThreePlayersViewController
            break
        case .four:
            viewController = storyboard.instantiateViewController(withIdentifier: "FourPlayersViewController") as! FourPlayersViewController
            break
        case .five:
            viewController = storyboard.instantiateViewController(withIdentifier: "FivePlayersViewController") as! FivePlayersViewController
            break
        case .six:
            viewController = storyboard.instantiateViewController(withIdentifier: "SixPlayersViewController") as! SixPlayersViewController
            break
        }
        viewController.startingLifeTotal = lifeTotal
        
        return viewController
    }
}
