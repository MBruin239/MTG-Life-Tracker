//
//  PlayerSelectorView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

protocol PlayerSelectorViewDelegate {
    func playerWasSelected()
}

class PlayerSelectorView: CustomView {
    let kCONTENT_XIB_NAME = "PlayerSelectorView"
    
    var delegate: PlayerSelectorViewDelegate?
    
    @IBOutlet var skipButton: CustomButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var circleViews: [Int:CircleView] = [:]
    
    var expectedNumberOfPlayers: PlayerCount = .two
    var playerSelectorTimer: Timer?
    
    var winnerPicked: Bool = false

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        self.isMultipleTouchEnabled = true
        
        self.addBlurEffect(alpha: 0.9)
    }
    
    @IBAction func skipButtonPress() {
        delegate?.playerWasSelected()
    }
    
    func hideContent(hide: Bool){
        skipButton.isHidden = hide
        titleLabel.isHidden = hide
        descriptionLabel.isHidden = hide
    }
    
    func startPlayerSelectorTimer() {
        if circleViews.count == expectedNumberOfPlayers.rawValue {
            startAnimations()
            playerSelectorTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(pickWinner), userInfo: nil, repeats: false)
        }
    }
    
    func startAnimations() {
        let keys = [Int](circleViews.keys)

        for key in keys{
            if let circleView = circleViews[key] {
                circleView.startAnimations()
            }
        }
    }
    
    func removeAnimations() {
        let keys = [Int](circleViews.keys)

        for key in keys{
            if let circleView = circleViews[key] {
                circleView.layer.removeAllAnimations()
            }
        }
    }
    
    @objc func pickWinner() {
        guard circleViews.count > 0 else {
            return
        }
        let rand = Int.random(in: 0..<circleViews.count)
        
        let keys = [Int](circleViews.keys)
        for i in stride(from: circleViews.count-1, through: 0, by: -1) {
            if let circleView = circleViews[keys[i]] {
                circleView.layer.removeAllAnimations()
                var rect = circleView.frame
                rect.size = CGSize.init(width: rect.size.width*2, height: rect.size.width*2)
                circleView.changeFrame(frame: rect)
            }
            if i == rand {
                continue
            } else {
                if let circleView = circleViews.removeValue(forKey: keys[i]) {
                    circleView.removeFromSuperview()
                }
            }
        }
        winnerPicked = true
        playerSelectorTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(transitionAway), userInfo: nil, repeats: false)
    }
    
    @objc func transitionAway() {
        delegate?.playerWasSelected()
    }
}

extension PlayerSelectorView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !winnerPicked else {
            return
        }
        hideContent(hide: true)
        event?.allTouches?.forEach {
            if let circleView = circleViews[$0.hash] {
                circleViews.updateValue(circleView, forKey: $0.hash)
            } else {
                if circleViews.count < expectedNumberOfPlayers.rawValue {
                    let point = $0.location(in: self)

                    let circleView = CircleView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
                    circleView.center = point
                    circleView.lastCenter = point
                            
                    contentView.addSubview(circleView)
                    circleViews.updateValue(circleView, forKey: $0.hash)
                }
                startPlayerSelectorTimer()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        event?.allTouches?.forEach {
            if let circleView = circleViews[$0.hashValue] {
                let point = $0.location(in: self)
                 circleView.center = point
                circleView.lastCenter = point
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        event?.allTouches?.forEach {
            if $0.phase == UITouch.Phase.ended {
                if let circleView = circleViews[$0.hashValue] {
                    circleView.removeFromSuperview()
                    circleViews.removeValue(forKey: $0.hashValue)
                }
            }
        }
        if winnerPicked && circleViews.count == 0 {
            transitionAway()
        } else if circleViews.count == 0 {
            hideContent(hide: false)
            playerSelectorTimer?.invalidate()
        } else if circleViews.count < expectedNumberOfPlayers.rawValue {
            playerSelectorTimer?.invalidate()
            removeAnimations()
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        event?.allTouches?.forEach {
            if $0.phase == UITouch.Phase.cancelled {
                if let circleView = circleViews[$0.hashValue] {
                    circleView.removeFromSuperview()
                    circleViews.removeValue(forKey: $0.hashValue)
                }
            }
        }
    }
}
