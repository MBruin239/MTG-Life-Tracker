//
//  EffectsView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 8/14/22.
//

import UIKit

protocol EffectsViewDelegate {
    func EffectsViewWillClose()
    func showCitysBlessing(_ show: Bool)
    func showDead(_ show: Bool)
}

class EffectsView: CustomView {
    var playerID: Int = -1
    let kCONTENT_XIB_NAME = "EffectsView"
    
    var delegate: EffectsViewDelegate?

    @IBOutlet var monarchButton: CustomButton!
    @IBOutlet var citysBlessingButton: CustomButton!
    @IBOutlet var delveButton: CustomButton!
    @IBOutlet var deadButton: CustomButton!
    
    @IBOutlet var doneButton: CustomButton!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        monarchButton.centerVertically()
        monarchButton.cornerRadius = 10
        citysBlessingButton.centerVertically()
        citysBlessingButton.cornerRadius = 10
        delveButton.centerVertically()
        delveButton.cornerRadius = 10
        deadButton.centerVertically()
        deadButton.cornerRadius = 10
        
        doneButton.cornerRadius = 10.0
    }
    
    func resetEffects() {
        monarchButton.deselect()
        delveButton.deselect()
        citysBlessingButton.deselect()
        deadButton.deselect()
        
        sendMonarchNotification(false)
        sendDelveNotification(false)
        delegate?.showDead(false)
        delegate?.showCitysBlessing(false)
    }
    
    func sendMonarchNotification(_ selected: Bool) {
        let id = selected ? playerID : -1
        NotificationCenter.default.post(name: Notification.Name("NewMonarchNotification"), object: nil, userInfo: ["playerID":id])
    }
    
    func sendDelveNotification(_ selected: Bool) {
        let id = selected ? playerID : -1
        NotificationCenter.default.post(name: Notification.Name("NewDelverNotification"), object: nil, userInfo: ["playerID":id])
    }
    
    func updateButton(_ sender: CustomButton) {
        if sender.isSelected == false {
            sender.select()
        } else {
            sender.deselect()
        }
    }
    
    @IBAction func monarchButtonPress(_ sender: CustomButton) {
        updateButton(sender)
        sendMonarchNotification(sender.isSelected)
    }
    
    @IBAction func citysBlessingButtonPress(_ sender: CustomButton) {
        updateButton(sender)
        delegate?.showCitysBlessing(sender.isSelected)
    }
    
    @IBAction func delveButtonPress(_ sender: CustomButton) {
        updateButton(sender)
        sendDelveNotification(sender.isSelected)
    }
    
    @IBAction func deadButtonPress(_ sender: CustomButton) {
        updateButton(sender)
        delegate?.showDead(sender.isSelected)
    }
    
    @IBAction func doneButtonPress(){
        self.removeFromSuperview()
        delegate?.EffectsViewWillClose()
    }
}
