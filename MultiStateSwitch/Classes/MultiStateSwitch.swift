//
//  MultiStateSwitch.swift
//  MultiStateSwitch
//
//  Created by Sarawanak on 7/25/17.
//

import UIKit
@IBDesignable
open class MultiStateSwitch: UIControl, CAAnimationDelegate {

    private let stateIndicator = CAShapeLayer()
    private let controlLayer = CALayer()
    
    private var startIndex: Int?
    private var endIndex: Int?
    private var indicatorPosition: CGPoint!
    private var selectedIndex = 0
    
    @IBInspectable open var stateImages: [UIImage]!
    @IBInspectable open var stateSize: Int = 64
    
    private var totalStates: Int {
        return (stateImages == nil) ? 2 : stateImages.count
    }
    
    open var currentIndex: Int {
        get {
            return self.selectedIndex
        }
        set {
            performSwitch(to: newValue)
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public convenience init(_ states: [UIImage], _ size: Int = 64) {
        self.init(frame: CGRect(x: 0, y: 0, width: ((size + 1) * states.count)+1, height: (size + 2)))
        stateImages = states
        stateSize = size
    }
    
    override open func draw(_ rect: CGRect) {
        
        controlLayer.frame = CGRect(x: 0, y: 0, width: ((stateSize + 1) * totalStates)+2, height: (stateSize + 2))
        controlLayer.borderColor = UIColor.gray.cgColor
        controlLayer.borderWidth = 1.0
        controlLayer.cornerRadius = CGFloat(stateSize / 2)
        clipsToBounds = true
        
        for i in 0..<totalStates {
            let stateLayer = CALayer()
            stateLayer.frame = CGRect(x: 1 + (stateSize + 1) * i, y: 1, width: stateSize, height: stateSize)
            if stateImages != nil {
                stateLayer.contents = stateImages[i].cgImage
            }
            stateLayer.transform = CATransform3DMakeScale(0.55, 0.55, 1.0)
            
            controlLayer.addSublayer(stateLayer)
        }
        
        stateIndicator.frame = CGRect(x: 0, y: 0, width: (stateSize + 1), height: (stateSize + 1))
        stateIndicator.backgroundColor = UIColor(colorLiteralRed: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 0.3).cgColor
        stateIndicator.cornerRadius = stateIndicator.frame.height / 2
        stateIndicator.borderColor = UIColor.blue.cgColor
        stateIndicator.borderWidth = 1.0
        controlLayer.addSublayer(stateIndicator)
        
        indicatorPosition = CGPoint(x: stateIndicator.frame.midX, y: stateIndicator.frame.midY)
        layer.addSublayer(controlLayer)
        self.sendActions(for: UIControlEvents.valueChanged)
    }
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if let loc = touch?.location(in: self) {
            endIndex = getIndexForLocation(loc)
            performSwitch(to: endIndex!)
        }
    }
    
    func performSwitch(to index: Int) -> () {
        guard selectedIndex != index else {
            return
        }
        
        let offsetDiff = CGFloat((index - selectedIndex) * (stateSize + 2))
        let oldPosition = indicatorPosition
        indicatorPosition.x += offsetDiff
        let newPosition = indicatorPosition
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
        animation.duration = 0.6
        animation.fromValue = NSValue(cgPoint: oldPosition!)
        animation.toValue = NSValue(cgPoint: newPosition!)
        animation.autoreverses = false
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        
        self.selectedIndex = index
        self.stateIndicator.add(animation, forKey: "position")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.sendActions(for: UIControlEvents.valueChanged)
        }
    }
    
    func getIndexForLocation(_ point: CGPoint) -> Int {
        var index = selectedIndex
        let sLayers = self.controlLayer.sublayers
        for i in 0..<totalStates {
            if sLayers![i].frame.contains(point) {
                index = i
            }
        }
        return index
    }

}
