//
//  ThreePlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import Foundation
import UIKit

class ThreePlayersView: PlayersView {
    let kCONTENT_XIB_NAME = "ThreePlayersView"
   
    @IBOutlet var player1Parrent: UIView!
    var playerView1: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var player2Parrent: UIView!
    var playerView2: LifeTrackerView = LifeTrackerView()
    
    @IBOutlet var playerView3: LifeTrackerView!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    override func setup() {
        playerView1.lifeTotal = startingLifeTotal
        playerView2.lifeTotal = startingLifeTotal
        playerView3.lifeTotal = startingLifeTotal
        
        playerView1.rotateViewInView(player1Parrent, rotation: Double.pi*0.5)
        playerView2.rotateViewInView(player2Parrent, rotation: Double.pi*1.5)
    }
}
