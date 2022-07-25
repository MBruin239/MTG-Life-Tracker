//
//  MainCoordinator.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit

let userDefaults = UserDefaults.standard

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewControllerProvider.optionsViewController
        vc.coordinator = self
        
        navigationController.setNavigationBarHidden(true, animated: false)

        navigationController.pushViewController(vc, animated: false)
    }

    func startGameViewController(lifeTotal: Int, numPlayers: PlayerCount) {
        let gameVC = ViewControllerProvider.startGameViewController(lifeTotal: lifeTotal, numPlayers: numPlayers)
        gameVC.coordinator = self
        navigationController.pushViewController(gameVC, animated: true)
    }
}
