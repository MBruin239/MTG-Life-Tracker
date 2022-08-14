//
//  OptionsView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit

protocol OptionsViewDelegate {
    func openCounterSelectorView(counterSelectorView: CountersSelectorView)
    func openEffectsView(effectsView: EffectsView)
    func openFontPickerViewController()
    func showCountersOfTypes(counterTypeArray: [(CounterType, UIImage?)])
    func setBackgroundColor(color: UIColor)
    func closeOptionsView()
    func showCitysBlessing(_ show: Bool)
    func showDead(_ show: Bool)
}

class OptionsView: CustomView {
    var playerID: Int = -1 { didSet { effectsView.playerID = playerID } }
    let kCONTENT_XIB_NAME = "OptionsView"
    
    var delegate: OptionsViewDelegate?
    
    var countersView: CountersSelectorView = CountersSelectorView()
    var colorView: ColorPickerView = ColorPickerView()
    var theColor: UIColor = .white
    
    var effectsView: EffectsView = EffectsView()

    @IBOutlet var countersButton: CustomButton!
    @IBOutlet var effectsButton: CustomButton!
    @IBOutlet var colorsButton: CustomButton!
    @IBOutlet var fontButton: CustomButton!

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        countersButton.centerVertically()
        effectsButton.centerVertically()
        colorsButton.centerVertically()
        fontButton.centerVertically()
        
        countersView.delegate = self
        colorView.delegate = self
        effectsView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func resetOptions() {
        resetCounters()
        resetEffects()
    }
    
    func resetCounters() {
        countersView = CountersSelectorView()
        countersView.delegate = self
    }
    
    func resetEffects() {
        effectsView.resetEffects()
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        delegate?.closeOptionsView()
    }
    
    @IBAction func countersButtonPress() {
        delegate?.openCounterSelectorView(counterSelectorView: countersView)
    }
    
    @IBAction func fontButtonPress() {
        delegate?.openFontPickerViewController()
    }
    
    @IBAction func effectsButtonPress() {
        delegate?.openEffectsView(effectsView: effectsView)
    }
    
    @IBAction func colorButtonPress() {
        colorView.setTheColor(color: theColor)
        colorView.frame = self.frame
        self.addSubview(colorView)
    }
}

extension OptionsView: CountersSelectorViewDelegate{
    func showCountersOfTypes(counterTypeArray: [(CounterType, UIImage?)]) {
        delegate?.showCountersOfTypes(counterTypeArray: counterTypeArray)
    }
}

extension OptionsView: ColorPickerViewDelegate{
    func colorPickerViewWillClose() {
        delegate?.closeOptionsView()
    }
    
    func setBackgroundColor(color: UIColor) {
        theColor = color
        delegate?.setBackgroundColor(color: color)
    }
}

extension OptionsView: EffectsViewDelegate {
    func EffectsViewWillClose() {
        delegate?.closeOptionsView()
    }
    
    func showCitysBlessing(_ show: Bool) {
        delegate?.showCitysBlessing(show)
    }
    
    func showDead(_ show: Bool) {
        delegate?.showDead(show)
    }
}
