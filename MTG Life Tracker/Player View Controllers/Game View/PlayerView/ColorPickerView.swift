//
//  ColorPickerView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 8/10/22.
//

import Foundation
import UIKit

protocol ColorPickerViewDelegate {
    func colorPickerViewWillClose()
    func setBackgroundColor(color: UIColor)
}

class ColorPickerView: CustomView {
    let kCONTENT_XIB_NAME = "ColorPickerView"
    
    var delegate: ColorPickerViewDelegate?
    
    @IBOutlet var closeButton: CustomButton!
    
    var theColor: UIColor = .white { didSet { delegate?.setBackgroundColor(color: theColor) } }
    
    @IBOutlet var redSlider: UISlider!
    var redValue: Double = 0 { didSet {theColor = UIColor.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0) } }

    @IBOutlet var greenSlider: UISlider!
    var greenValue: Double = 0 { didSet {theColor = UIColor.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0) } }

    @IBOutlet var blueSlider: UISlider!
    var blueValue: Double = 0 { didSet {theColor = UIColor.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0) } }
    
    func setTheColor(color: UIColor){
        theColor = color
        
        redSlider.value = Float(color.rgba.red)
        redValue = Double(color.rgba.red)
        greenSlider.value = Float(color.rgba.green)
        greenValue = Double(color.rgba.green)
        blueSlider.value = Float(color.rgba.blue)
        blueValue = Double(color.rgba.blue)
    }

    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    @IBAction func redSliderValueChanged(_ sender: UISlider) {
        let currentValue = Double(sender.value)
            
        redValue = currentValue
    }
    
    @IBAction func greenSliderValueChanged(_ sender: UISlider) {
        let currentValue = Double(sender.value)
            
        greenValue = currentValue
    }
    
    @IBAction func blueSliderValueChanged(_ sender: UISlider) {
        let currentValue = Double(sender.value)
            
        blueValue = currentValue
    }
    
    @IBAction func closeButtonPress() {
        delegate?.colorPickerViewWillClose()
        self.removeFromSuperview()
    }
    
}

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
