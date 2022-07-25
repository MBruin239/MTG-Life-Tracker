//
//  SixPlayersViewController.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/24/22.
//

import UIKit

class SixPlayersViewController: PlayersViewController {
    @IBOutlet var player1Parrent: UIView!
    var playerView1: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var player2Parrent: UIView!
    var playerView2: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var player3Parrent: UIView!
    var playerView3: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var player4Parrent: UIView!
    var playerView4: LifeTrackerView = LifeTrackerView()

    @IBOutlet var player5Parrent: UIView!
    var playerView5: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var player6Parrent: UIView!
    var playerView6: LifeTrackerView = LifeTrackerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView1.lifeTotal = startingLifeTotal!
        playerView2.lifeTotal = startingLifeTotal!
        playerView3.lifeTotal = startingLifeTotal!
        playerView4.lifeTotal = startingLifeTotal!
        playerView5.lifeTotal = startingLifeTotal!
        playerView6.lifeTotal = startingLifeTotal!

        playerView1.rotateViewInView(player1Parrent, rotation: Double.pi*0.5)
        playerView2.rotateViewInView(player2Parrent, rotation: Double.pi*0.5)
        playerView3.rotateViewInView(player3Parrent, rotation: Double.pi*0.5)
        playerView4.rotateViewInView(player4Parrent, rotation: Double.pi*1.5)
        playerView5.rotateViewInView(player5Parrent, rotation: Double.pi*1.5)
        playerView6.rotateViewInView(player6Parrent, rotation: Double.pi*1.5)

    }
}
