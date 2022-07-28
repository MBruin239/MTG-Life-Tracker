//
//  ViewControllerProvider.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import Foundation
import UIKit

enum ViewControllerProvider {
    static var optionsViewController: OptionsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController
        return viewController
    }

    static func startGameViewController(lifeTotal: Int, numPlayers: PlayerCount) -> PlayersViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayersViewController") as! PlayersViewController

        viewController.startingLifeTotal = lifeTotal
        viewController.numberOfPlayers = numPlayers
        
        return viewController
    }
}
