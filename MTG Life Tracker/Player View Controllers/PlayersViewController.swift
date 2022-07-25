//
//  PlayersViewController.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit

class PlayersViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    var startingLifeTotal: Int?{ didSet{ } }
        
    @IBAction func menuButtonPress() {
        coordinator?.start()
    }
}
