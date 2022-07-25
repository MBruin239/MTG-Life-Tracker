//
//  OptionsView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/23/22.
//

import UIKit

class OptionsView: CustomView {
    let kCONTENT_XIB_NAME = "OptionsView"
        
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
}
