//
//  OptionsView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit

protocol OptionsViewDelegate {
    func openCounterSelectorView(counterSelectorView: CountersSelectorView)
    func showCountersOfTypes(counterTypeArray: [(CounterType, UIImage?)])
}

class OptionsView: CustomView {
    let kCONTENT_XIB_NAME = "OptionsView"
    
    var delegate: OptionsViewDelegate?
    
    var countersView: CountersSelectorView = CountersSelectorView()

    @IBOutlet var countersButton: UIButton!
        
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        countersView.delegate = self
    }
    
    @IBAction func countersButtonPress() {
        delegate?.openCounterSelectorView(counterSelectorView: countersView)
    }
}

extension OptionsView: CountersSelectorViewDelegate{
    func showCountersOfTypes(counterTypeArray: [(CounterType, UIImage?)]) {
        delegate?.showCountersOfTypes(counterTypeArray: counterTypeArray)
    }
}
