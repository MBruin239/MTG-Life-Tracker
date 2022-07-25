//
//  ThreePlayersViewController.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/24/22.
//

import UIKit

class ThreePlayersViewController: PlayersViewController {
    @IBOutlet var player1Parrent: UIView!
    var playerView1: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var player2Parrent: UIView!
    var playerView2: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var playerView3: LifeTrackerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView1.lifeTotal = startingLifeTotal!
        playerView2.lifeTotal = startingLifeTotal!
        playerView3.lifeTotal = startingLifeTotal!
        
        playerView1.rotateViewInView(player1Parrent, rotation: Double.pi*0.5)
        playerView2.rotateViewInView(player2Parrent, rotation: Double.pi*1.5)

    }
}
