//
//  PlayerView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

class PlayerView: CustomView {
    let kCONTENT_XIB_NAME = "PlayerView"

    @IBOutlet var playerLifeView: LifeTrackerView!

    @IBOutlet var mainStack: UIStackView!
    var countersStack: UIStackView = UIStackView()
    
    @IBOutlet var pannableView: UIView!
    @IBOutlet var behindColorView: UIView!
    @IBOutlet var optionsView: OptionsView!
    
    private var initialCenter: CGPoint = .zero
            
    override func commonInit() {
        super.commonInit()
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
        
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layer.cornerRadius = 15
        
        countersStack.axis = NSLayoutConstraint.Axis.horizontal
        countersStack.distribution = UIStackView.Distribution.fillEqually
        countersStack.spacing = 1.0
        
        pannableView.clipsToBounds = true
        pannableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        pannableView.layer.cornerRadius = 15
        
        pannableView.center = self.center
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        pannableView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        optionsView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addCounterViewToStack(view: LifeTrackerView){
        mainStack.addArrangedSubview(countersStack)
        countersStack.addArrangedSubview(view)
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            initialCenter = pannableView.center
        case .changed:
            let translation = sender.translation(in: self.contentView)
            
            if initialCenter.y + translation.y < contentView.center.y {
                return
            }
            
            pannableView.center = CGPoint(x: initialCenter.x,
                                          y: initialCenter.y + translation.y)
        case .ended, .cancelled:
            let translation = sender.translation(in: self.contentView)

            if translation.y > initialCenter.y {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [self] in
                    let leftOverAmount = pannableView.frame.height * 0.8
                    let rect = CGRect.init(x: contentView.frame.origin.x, y: leftOverAmount, width: contentView.frame.width, height: contentView.frame.height)
                    pannableView.frame = rect
                }
            } else {
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [self] in
                    pannableView.center = contentView.center
                }
            }
        default:
            break
        }
    }
    
    @objc private func didTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [self] in
            pannableView.center = contentView.center
        }
    }

}