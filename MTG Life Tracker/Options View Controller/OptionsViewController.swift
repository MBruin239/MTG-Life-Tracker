//
//  OptionsViewController.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/24/22.
//

import UIKit

class OptionsViewController: UIViewController {
    var coordinator: MainCoordinator?

    var startingLifeTotalView: StartingLifeTotalView = StartingLifeTotalView()
    var numberOfPlayersView: NumberOfPlayersView = NumberOfPlayersView()
    
    var startingLifeTotal: Int?
    var numberOfPlayers: PlayerCount?

    override func viewDidLoad() {
        startingLifeTotalView.frame = self.view.frame
        startingLifeTotalView.delegate = self
        self.view.addSubview(startingLifeTotalView)
    }
}

extension OptionsViewController: StartingLifeTotalViewDelegate {
    func setStartingLifeTotal(lifeTotal: Int) {
        startingLifeTotal = lifeTotal
        numberOfPlayersView.transitionInFromRight(container: self.view, oldView: startingLifeTotalView)
        numberOfPlayersView.delegate = self
    }
}

extension OptionsViewController: NumberOfPlayersViewDelegate {
    func numberOfPlayersViewBackButtonPress() {
        startingLifeTotalView.transitionInFromLeft(container: self.view, oldView: numberOfPlayersView)
    }

    func setNumberOfPlayers(playerCount: PlayerCount) {
        numberOfPlayers = playerCount
        coordinator?.startGameViewController(lifeTotal: startingLifeTotal!, numPlayers: numberOfPlayers!)
    }
}
