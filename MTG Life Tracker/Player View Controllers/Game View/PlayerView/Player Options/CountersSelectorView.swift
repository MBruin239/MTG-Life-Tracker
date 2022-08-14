//
//  CountersSelectorView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/27/22.
//

import UIKit

enum CounterType {
    case life
    case star
    case book
    case theature
    case sun
    case paperPlane
    case moon
    case cloud
    case snow
    case umbrella
    case flame
    case club
    case spade
}

protocol CountersSelectorViewDelegate {
    func showCountersOfTypes(counterTypeArray: [(CounterType, UIImage?)])
}

class CountersSelectorView: CustomView {
    let kCONTENT_XIB_NAME = "CountersSelectorView"
    
    var delegate: CountersSelectorViewDelegate?
    
    var counterTypeArray: [(CounterType, UIImage?)] = []
    
    @IBOutlet var starButton: CustomButton!
    @IBOutlet var bookButton: CustomButton!
    @IBOutlet var theatureButton: CustomButton!
    @IBOutlet var sunButton: CustomButton!
    @IBOutlet var paperPlaneButton: CustomButton!
    @IBOutlet var moonButton: CustomButton!
    @IBOutlet var snowButton: CustomButton!
    @IBOutlet var cloudButton: CustomButton!
    @IBOutlet var umbrellaButton: CustomButton!
    @IBOutlet var flameButton: CustomButton!
    @IBOutlet var clubButton: CustomButton!
    @IBOutlet var spadeButton: CustomButton!
    
    @IBOutlet var doneButton: CustomButton!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        starButton.setupCounterButton(counterType: .star)

        bookButton.setupCounterButton(counterType: .book)

        theatureButton.setupCounterButton(counterType: .theature)

        sunButton.setupCounterButton(counterType: .sun)
        
        paperPlaneButton.setupCounterButton(counterType: .paperPlane)

        moonButton.setupCounterButton(counterType: .moon)

        snowButton.setupCounterButton(counterType: .snow)

        cloudButton.setupCounterButton(counterType: .cloud)
        
        umbrellaButton.setupCounterButton(counterType: .umbrella)

        flameButton.setupCounterButton(counterType: .flame)

        clubButton.setupCounterButton(counterType: .club)

        spadeButton.setupCounterButton(counterType: .spade)
        
        doneButton.cornerRadius = 10.0
        
        doneButton.setTitle("Cancel", for: .normal)
    }
    
    @IBAction func toggleButton(_ sender: CustomButton) {
        if sender.isSelected == false {
            sender.select()
            counterTypeArray.append((sender.counterType, sender.imageView?.image))
            doneButton.setTitle("Done", for: .normal)
        } else {
            sender.deselect()
            for i in stride(from: counterTypeArray.count-1, through: 0, by: -1) {
                if counterTypeArray[i].0 == sender.counterType {
                    counterTypeArray.remove(at: i)
                }
            }
        }
        if counterTypeArray.count == 0 {
            doneButton.setTitle("Cancel", for: .normal)
        }
    }
    
    @IBAction func doneButtonPress(){
        delegate?.showCountersOfTypes(counterTypeArray: counterTypeArray)
        self.removeFromSuperview()
    }
}
