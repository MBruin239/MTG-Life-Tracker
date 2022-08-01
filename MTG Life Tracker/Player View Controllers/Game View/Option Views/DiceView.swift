//
//  DiceView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/31/22.
//

import Foundation
import UIKit

protocol DiceViewDelegate {
    func dismissView()
}

class DiceView: CustomView {
    let kCONTENT_XIB_NAME = "DiceView"
    
    var delegate: DiceViewDelegate?
    
    @IBOutlet var rollLabel: UILabel!
    
    @IBOutlet var fourButton: DiceButton!
    @IBOutlet var sixButton: DiceButton!
    @IBOutlet var eightButton: DiceButton!
    @IBOutlet var tenButton: DiceButton!
    @IBOutlet var twelveButton: DiceButton!
    @IBOutlet var twentyButton: DiceButton!
    @IBOutlet var oneHundredButton: DiceButton!
    
    @IBOutlet var numberOfDicePickerView: UIPickerView! { didSet { numberOfDicePickerView.delegate = self; numberOfDicePickerView.dataSource = self} }
    
    let numberOfDiceArray = [1,2,3,4,5,6,7,8,9,10]
    var numberOfDice = 1

    @IBOutlet var closeButton: CustomButton!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        closeButton.contentHorizontalAlignment = .fill
        closeButton.contentVerticalAlignment = .fill
        
        fourButton.numberOfSides = 4
        sixButton.numberOfSides = 6
        eightButton.numberOfSides = 8
        tenButton.numberOfSides = 10
        twelveButton.numberOfSides = 12
        twentyButton.numberOfSides = 20
        oneHundredButton.numberOfSides = 100
        
        numberOfDicePickerView.layer.cornerRadius = 10
        
        self.addBlurEffect(alpha: 0.9)
    }
    
    @IBAction func diceButtonPress(_ sender: DiceButton) {
        let number = rollDice(sides: sender.numberOfSides, numberOfDice: numberOfDice)
        print(number)
        rollLabel.text = String(number)
    }
    
    @IBAction func closeButtonPress(_ sender: CustomButton) {
        delegate?.dismissView()
    }
    
    func rollDice(sides: Int, numberOfDice: Int) -> Int {
        var total = 0
        for _ in 1...numberOfDice {
            let rand = Int.random(in: 1...sides)
            total = total + rand
        }
        return total
    }
}

// MARK: Picker View Delegate functions
extension DiceView: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return numberOfDiceArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = String(numberOfDiceArray[row])

        return title
    }
}

extension DiceView: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberOfDice = numberOfDiceArray[row]
    }
}
