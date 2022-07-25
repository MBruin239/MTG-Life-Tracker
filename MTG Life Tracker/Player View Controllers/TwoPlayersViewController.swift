//
//  TwoPlayersViewController.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit

class TwoPlayersViewController: PlayersViewController {
    @IBOutlet var playerView1: LifeTrackerView!
    @IBOutlet var playerView2: LifeTrackerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        playerView1.transform = playerView1.transform.rotated(by: Double.pi);
        playerView1.lifeTotal = startingLifeTotal!
        playerView2.lifeTotal = startingLifeTotal!

    }

}

