//
//  PlayerView.swift
//  MTG Life Tracker
//
//  Created by Michael  Bruin on 7/25/22.
//

import UIKit

protocol PlayerViewDelegate {
    func openCounterSelectorView(counterSelectorView: CountersSelectorView)
}

class PlayerView: CustomView {
    let kCONTENT_XIB_NAME = "PlayerView"
    
    var delegate: PlayerViewDelegate?

    @IBOutlet var playerLifeView: LifeTrackerView!

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainStack: UIStackView!
    var countersStack: UIStackView = UIStackView()
    
    @IBOutlet var pannableView: UIView!
    @IBOutlet var behindColorView: UIView!
    @IBOutlet var optionsView: OptionsView! { didSet { optionsView.delegate = self } }
    
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
        
        let theColor = UIColor.random()
        playerLifeView.contentView.backgroundColor = theColor
        optionsView.theColor = theColor
        
        let widthConstraint = NSLayoutConstraint(item: playerLifeView!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 150)
        playerLifeView.addConstraints([widthConstraint])
    }
    
    func resetGame(with startingLifeTotal: Int){
        playerLifeView.lifeTotal = startingLifeTotal
        removeAllCounterViews()
        optionsView.resetOptions()
        slidePanableViewToTop()
    }
    
    func setPanableViewToBottom() {
        let leftOverAmount = pannableView.frame.height * 0.8
        let rect = CGRect.init(x: contentView.frame.origin.x, y: leftOverAmount, width: contentView.frame.width, height: contentView.frame.height)
        pannableView.frame = rect
    }
    
    func slidePanableViewToBottom() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [self] in
            setPanableViewToBottom()
        }
        // Disable the top button so you don't change the life trying to pan the view around
        playerLifeView.topButton.isEnabled = false
    }
    
    func slidePanableViewToTop() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) { [self] in
            pannableView.center = contentView.center
        }
        // Make sure the top button is re-enabled when back to normal positioning
        playerLifeView.topButton.isEnabled = true
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
                slidePanableViewToBottom()
            } else {
                slidePanableViewToTop()
            }
        default:
            break
        }
    }
}

extension PlayerView: OptionsViewDelegate {
    func closeOptionsView() {
        slidePanableViewToTop()
    }
    
    func setBackgroundColor(color: UIColor) {
        playerLifeView.contentView.backgroundColor = color
    }

    func showCountersOfTypes(counterTypeArray: [(CounterType, UIImage?)]) {
        // First we need to see if any counter views need removed
        checkIfCounterViewsNeedRemoved(counterTypeArray: counterTypeArray)
        
        for counterTuple in counterTypeArray {
                let counterType = counterTuple.0
            if !checkIfCounterViewExists(counterType: counterType){
                if let image = counterTuple.1 {
                    let counterView = makeCounterView(counterType: counterType, image: image)
                    counterView.contentView.backgroundColor = playerLifeView.contentView.backgroundColor
                    addCounterViewToStack(view: counterView)
                }
            }
        }
        // Move the view back up automatically
        slidePanableViewToTop()
    }
    
    func openCounterSelectorView(counterSelectorView: CountersSelectorView) {
        delegate?.openCounterSelectorView(counterSelectorView: counterSelectorView)
    }
}

extension PlayerView {
    
    private func removeAllCounterViews() {
        for view in countersStack.subviews {
            if let counterView = view as? LifeTrackerView {
                counterView.removeFromSuperview()
            }
        }
        countersStack.isHidden = true
    }
    
    func checkIfCounterViewExists(counterType: CounterType) -> Bool {
        for view in countersStack.subviews {
            if let counterView = view as? LifeTrackerView {
                if counterView.counterType == counterType {
                    return true
                }
            }
        }
        return false
    }
    
    func makeCounterView(counterType: CounterType, image: UIImage) -> LifeTrackerView {
        let counterView = LifeTrackerView()
        counterView.lifeTotal = 0
        counterView.counterType = counterType
        counterView.bottomImage.image = image
        
        let widthConstraint = NSLayoutConstraint(item: counterView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        counterView.addConstraints([widthConstraint])

        return counterView
    }
    
    func checkIfCounterTypeIsInArray(counterType: CounterType, counterTypeArray: [(CounterType, UIImage?)]) -> Bool {
        for object in counterTypeArray {
            if object.0 == counterType {
                return true
            }
        }
        return false
    }
    
    func checkIfCounterViewsNeedRemoved(counterTypeArray: [(CounterType, UIImage?)]) {
        for view in countersStack.subviews {
            if let counterView = view as? LifeTrackerView {
                if !checkIfCounterTypeIsInArray(counterType: counterView.counterType, counterTypeArray: counterTypeArray) {
                    counterView.removeFromSuperview()
                }
            }
        }
        
        changeMainStackDistribution()
        
        // If there are no more counterviews in the stack, hide the stack view
        if countersStack.subviews.count == 0 {
            countersStack.isHidden = true
        }
    }
    
    func changeMainStackDistribution(){
        if countersStack.subviews.count >= 3 {
            mainStack.distribution = UIStackView.Distribution.fillProportionally
        } else {
            mainStack.distribution = UIStackView.Distribution.fillEqually
        }
    }
    
    func addCounterViewToStack(view: LifeTrackerView){
        mainStack.addArrangedSubview(countersStack)
        countersStack.addArrangedSubview(view)
        countersStack.isHidden = false
        
        changeMainStackDistribution()
    }
}
