//
//  FivePlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import Foundation
import UIKit

class FivePlayersView: PlayersView {
    let kCONTENT_XIB_NAME = "FivePlayersView"
   
    @IBOutlet var player1Parrent: UIView!
    var playerView1: PlayerView = PlayerView()
    
    @IBOutlet var player2Parrent: UIView!
    var playerView2: PlayerView = PlayerView()
    
    @IBOutlet var player3Parrent: UIView!
    var playerView3: PlayerView = PlayerView()
    
    @IBOutlet var player4Parrent: UIView!
    var playerView4: PlayerView = PlayerView()

    @IBOutlet var player5Parrent: UIView!
    var playerView5: PlayerView = PlayerView()
    
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    override func setup() {
        super.setup()

        playerView1.playerLifeView.lifeTotal = startingLifeTotal
        playerView2.playerLifeView.lifeTotal = startingLifeTotal
        playerView3.playerLifeView.lifeTotal = startingLifeTotal
        playerView4.playerLifeView.lifeTotal = startingLifeTotal
        playerView5.playerLifeView.lifeTotal = startingLifeTotal

        playerView1.rotateViewInView(player1Parrent, rotation: Double.pi*0.5)
        playerView2.rotateViewInView(player2Parrent, rotation: Double.pi*0.5)
        playerView3.rotateViewInView(player3Parrent, rotation: Double.pi*1.5)
        playerView4.rotateViewInView(player4Parrent, rotation: Double.pi*1.5)
        playerView5.rotateViewInView(player5Parrent, rotation: Double.pi*1.5)
        
        playerView1.playerID = 1
        playerView2.playerID = 2
        playerView3.playerID = 3
        playerView4.playerID = 4
        playerView5.playerID = 5

        playerView1.delegate = self
        playerView2.delegate = self
        playerView3.delegate = self
        playerView4.delegate = self
        playerView5.delegate = self
        
        playersViewsArray.append(playerView1)
        playersViewsArray.append(playerView2)
        playersViewsArray.append(playerView3)
        playersViewsArray.append(playerView4)
        playersViewsArray.append(playerView5)
    }
}
