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
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func setup() {
        UIApplication.shared.isIdleTimerDisabled = true
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
        playersView?.numberOfPlayers = numberOfPlayers
        playersView?.delegate = self
    }
}

extension PlayersViewController: PlayersViewDelegate {
    
    func openCounterSelectorView(counterSelectorView: CountersSelectorView) {
        counterSelectorView.frame = self.view.frame
        self.view.addSubview(counterSelectorView)
    }
    
    func menuButtonPress() {
        coordinator?.start()
    }
}
