//
//  PlayersViewController.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit

class PlayersViewController: UIViewController {
    var coordinator: MainCoordinator?
    
    var playersView: PlayersView? { didSet {
        playersView?.frame = self.view.frame
        playersView?.delegate = self
        playersView?.startingLifeTotal = startingLifeTotal
        playersView?.setup()
        self.view.addSubview(playersView!)
    } }
    
    var startingLifeTotal: Int = 40
    var numberOfPlayers: PlayerCount = .two

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        switch numberOfPlayers {
            case .two:
                playersView = TwoPlayersView()
                break
            case .three:
                playersView = ThreePlayersView()
                break
            case .four:
                playersView = FourPlayersView()
                break
            case .five:
                playersView = FivePlayersView()
                break
            case .six:
                playersView = SixPlayersView()
                break
        }
    }
}

extension PlayersViewController: PlayersViewDelegate {
    func menuButtonPress() {
        coordinator?.start()
    }
}
