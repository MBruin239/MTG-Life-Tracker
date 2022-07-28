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
    
    @IBOutlet var doneButton: UIButton!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        starButton.setupCounterButton(counterType: .star)

        bookButton.setupCounterButton(counterType: .book)

        theatureButton.setupCounterButton(counterType: .theature)

        sunButton.setupCounterButton(counterType: .sun)

    }
    
    @IBAction func toggleButton(_ sender: CustomButton) {
        if sender.isSelected == false {
            sender.isSelected = true;
            sender.backgroundColor = .lightGray
            counterTypeArray.append((sender.counterType, sender.imageView?.image))
        } else {
            sender.isSelected = false;
            sender.backgroundColor = .clear
            for i in stride(from: counterTypeArray.count-1, through: 0, by: -1) {
                if counterTypeArray[i].0 == sender.counterType {
                    counterTypeArray.remove(at: i)
                }
            }
        }
    }
    
    @IBAction func doneButtonPress(){
        delegate?.showCountersOfTypes(counterTypeArray: counterTypeArray)
        self.removeFromSuperview()
    }
}
