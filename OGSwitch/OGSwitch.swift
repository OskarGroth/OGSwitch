//
//  OGSwitch.swift
//  OGSwitch
//
//  Created by Oskar Groth on 2017-02-22.
//  Copyright © 2017 Oskar Groth. All rights reserved.
//

import Cocoa
import QuartzCore

public class OGSwitch : NSControl {

    @IBInspectable public var tintColor: NSColor = NSColor(calibratedRed:0.27, green: 0.86, blue: 0.36, alpha: 1.0)
    @IBInspectable public var knobBackgroundColor: NSColor = NSColor(calibratedWhite:1.0, alpha: 1.0)
    @IBInspectable public var disabledBorderColor: NSColor = NSColor(calibratedWhite: 0.0, alpha: 0.2)
    @IBInspectable public var disabledBackgroundColor: NSColor = NSColor.clear
    @IBInspectable public var inactiveBackgroundColor: NSColor = NSColor(calibratedWhite: 0.0, alpha:0.3)
    @IBInspectable public var animationDuration: TimeInterval = 0.4
    
    let kBorderLineWidth:CGFloat = 1.0
    let kGoldenRatio:CGFloat = 1.6180339875
    let kDecreasedGoldenRatio:CGFloat = 1.38
    let kEnabledOpacity:Float = 1.0
    let kDisabledOpacity:Float = 0.5
    public var isOn:Bool = true
    public var isActive:Bool = false
    public var hasDragged:Bool  = false
    public var isDraggingTowardsOn:Bool = false
    public var rootLayer:CALayer?
    public var backgroundLayer:CALayer?
    public var knobLayer: CALayer?
    public var knobInsideLayer: CALayer?
    
    override public var acceptsFirstResponder: Bool {
        get {
            return true
        }
    }
    
    required public init?(coder:NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override init(frame:NSRect) {
        super.init(frame: frame);
        
        setup()
    }
    
    internal func setup() {
        isEnabled = true
        setupLayers()
    }
    
    internal func setupLayers() {
        rootLayer = CALayer()
        layer = rootLayer
        
        wantsLayer = true
        
        backgroundLayer = CALayer()
        backgroundLayer!.autoresizingMask = [.layerWidthSizable, .layerHeightSizable]
        backgroundLayer!.bounds = rootLayer!.bounds
        backgroundLayer!.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer!.borderWidth = kBorderLineWidth
        
        rootLayer!.addSublayer(backgroundLayer!)
        
        knobLayer = CALayer()
        knobLayer!.frame = rectForKnob()
        knobLayer!.autoresizingMask = CAAutoresizingMask.layerHeightSizable
        knobLayer!.backgroundColor = knobBackgroundColor.cgColor
        knobLayer!.shadowColor = NSColor.black.cgColor
        knobLayer!.shadowOffset = CGSize(width:0.0, height:-2.0)
        knobLayer!.shadowRadius = 1.0
        knobLayer!.shadowOpacity = 0.3
        rootLayer!.addSublayer(knobLayer!)
        
        knobInsideLayer = CALayer()
        knobInsideLayer!.frame = knobLayer!.bounds
        knobInsideLayer!.autoresizingMask = [.layerHeightSizable, .layerWidthSizable]
        
        knobInsideLayer!.shadowColor = NSColor.black.cgColor
        knobInsideLayer!.shadowOffset = CGSize(width:0.0, height:0.0)
        knobInsideLayer!.backgroundColor = NSColor.white.cgColor
        knobInsideLayer!.shadowRadius = 1.0
        knobInsideLayer!.shadowOpacity = 0.35
        knobLayer!.addSublayer(knobInsideLayer!)
        
        reloadLayerSize()
        reloadLayer()
    }
    
    internal func reloadLayerSize() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        knobLayer!.frame = rectForKnob()
        knobInsideLayer!.frame = knobLayer!.bounds
        
        backgroundLayer!.cornerRadius = backgroundLayer!.bounds.size.height / 2.0
        knobLayer!.cornerRadius = knobLayer!.bounds.size.height / 2.0
        knobInsideLayer!.cornerRadius = knobLayer!.bounds.size.height / 2.0
        
        CATransaction.commit()
    }
    
    public func reloadLayerAnimated(animated: Bool) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(animated ? animationDuration : 0)
        
        if (hasDragged && isDraggingTowardsOn) || (!hasDragged && isOn) {
            backgroundLayer!.borderColor = tintColor.cgColor
            backgroundLayer!.backgroundColor = tintColor.cgColor
        }
        else {
            backgroundLayer!.borderColor = disabledBorderColor.cgColor
            backgroundLayer!.backgroundColor = disabledBackgroundColor.cgColor
        }
        
        if isEnabled {
            rootLayer!.opacity = kEnabledOpacity
        }
        else {
            rootLayer!.opacity = kDisabledOpacity
        }
        
        if hasDragged {
            let function = CAMediaTimingFunction(controlPoints: 0.25, 1.5, 0.5, 1)
            CATransaction.setAnimationTimingFunction(function)
        }
        
        knobLayer!.frame = rectForKnob()
        knobInsideLayer!.frame = knobLayer!.bounds
        
        CATransaction.commit()
    }
    
    public func reloadLayer() {
        reloadLayerAnimated(animated: true)
    }
    
    internal func knobHeightForSize(_ size:NSSize) -> CGFloat {
        return size.height - kBorderLineWidth * 2.0;
    }
    
    internal func rectForKnob()->CGRect {
        let height = knobHeightForSize(backgroundLayer!.bounds.size)
        var width = 0.0
        
        let bounds: CGRect = backgroundLayer!.bounds
        
        if  isActive {
            width = Double((bounds.width - 2.0 * kBorderLineWidth) / kGoldenRatio)
        }
        else {
            width = Double((bounds.width - 2.0 * kBorderLineWidth) / kDecreasedGoldenRatio)
        }
        
        var x:CGFloat = 0
        if (!hasDragged && !isOn) || (hasDragged && !isDraggingTowardsOn) {
            x = kBorderLineWidth
        }
        else {
            x = bounds.width - CGFloat(width) - kBorderLineWidth
        }
        
        return CGRect(x: x, y: kBorderLineWidth, width: CGFloat(width), height: height)
    }
    
    override public func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        
        reloadLayerSize()
    }
    
    override public func acceptsFirstMouse(for theEvent: NSEvent!) -> Bool {
        return true
    }
    
    
    override public func mouseDown(with theEvent: NSEvent) {
        if !isEnabled {
            return
        }
        isActive = true
        reloadLayer()
    }
    
    override public func mouseDragged(with theEvent: NSEvent) {
        if !isEnabled {
            return
        }
        
        hasDragged = true
        
        let draggingPoint = convert(theEvent.locationInWindow, from: nil)
        isDraggingTowardsOn = draggingPoint.x > bounds.width  / 2.0
        reloadLayer()
    }
    
    override public func mouseUp(with theEvent: NSEvent) {
        if !isEnabled {
            return
        }
        
        var on = isOn
        isActive = false
        if hasDragged {
            on = isDraggingTowardsOn
        }
        else {
            on = !isOn
        }
        
        if isOn != on {
            Swift.print("Now: \(on)")
            if action != nil {
                NSApp.sendAction(action!, to: target, from: self)
            }
        }
        
        isOn = on
        
        hasDragged = false
        isDraggingTowardsOn = false
        
        reloadLayer()
    }
    
}
