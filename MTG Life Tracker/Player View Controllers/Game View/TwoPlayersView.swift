//
//  TwoPlayersView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import Foundation

class TwoPlayersView: PlayersView {
    let kCONTENT_XIB_NAME = "TwoPlayersView"
    @IBOutlet var playerView1: PlayerView! { didSet { playerView1.delegate = self } }
    @IBOutlet var playerView2: PlayerView! { didSet { playerView2.delegate = self } }

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    override func setup() {
        super.setup()
        
        playerView1.transform = playerView1.transform.rotated(by: Double.pi);
        playerView1.playerLifeView.lifeTotal = startingLifeTotal
        playerView2.playerLifeView.lifeTotal = startingLifeTotal
        
        playerView1.delegate = self
        playerView2.delegate = self
    }
}
