//
//  SixPlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import Foundation
import UIKit

class SixPlayersView: PlayersView {
    let kCONTENT_XIB_NAME = "SixPlayersView"
    
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
    
    @IBOutlet var player6Parrent: UIView!
    var playerView6: PlayerView = PlayerView()
    
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
        playerView6.playerLifeView.lifeTotal = startingLifeTotal

        playerView1.rotateViewInView(player1Parrent, rotation: Double.pi*0.5)
        playerView2.rotateViewInView(player2Parrent, rotation: Double.pi*0.5)
        playerView3.rotateViewInView(player3Parrent, rotation: Double.pi*0.5)
        playerView4.rotateViewInView(player4Parrent, rotation: Double.pi*1.5)
        playerView5.rotateViewInView(player5Parrent, rotation: Double.pi*1.5)
        playerView6.rotateViewInView(player6Parrent, rotation: Double.pi*1.5)
        
        playerView1.delegate = self
        playerView2.delegate = self
        playerView3.delegate = self
        playerView4.delegate = self
        playerView5.delegate = self
        playerView6.delegate = self
        
        playersViewsArray.append(playerView1)
        playersViewsArray.append(playerView2)
        playersViewsArray.append(playerView3)
        playersViewsArray.append(playerView4)
        playersViewsArray.append(playerView5)
        playersViewsArray.append(playerView6)
    }
}
