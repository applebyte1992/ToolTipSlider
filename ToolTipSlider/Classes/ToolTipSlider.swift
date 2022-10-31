//
//  ToolTipSlider.swift
//  Pods
//
//  Created by Masroor Mac on 13/03/2020.
//

import UIKit

class ToolTipSlider: UISlider {
    
    var toolTipThumb = ToolTipView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    func setup() {
        self.toolTipThumb.backgroundColor = UIColor.clear
        self.addSubview(self.toolTipThumb)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.toolTipThumb.updateValue(value: 2)
        }
        
    }
    
    func knobRect() -> CGRect {
        let knobRect = self.thumbRect(forBounds: self.bounds, trackRect: self.trackRect(forBounds: self.bounds), value: self.value)
        return knobRect
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if self.knobRect().contains(touchPoint) {
            self.updateToolTipView()
            self.animateToolTip(fadeIn: true)
        }
        return super.beginTracking(touch, with: event)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.updateToolTipView()
        return super.continueTracking(touch, with: event)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.animateToolTip(fadeIn: false)
        super.endTracking(touch, with: event)
    }
    
    
    func updateToolTipView() {
        let thumbRect = self.knobRect()
        let popupRect = thumbRect.offsetBy(dx: 0, dy: -thumbRect.size.height)
        toolTipThumb.frame = popupRect.insetBy(dx: 0, dy: 0)
        toolTipThumb.updateValue(value: Int(self.value * 100))
    }
    
    func animateToolTip(fadeIn : Bool) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        if fadeIn {
            toolTipThumb.alpha = 1.0
        } else {
            toolTipThumb.alpha = 0.0
        }
        UIView.commitAnimations()
    }
}

//- (void)animateToolTipFading:(BOOL)aFadeIn {
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    if (aFadeIn) {
//        toolTip.alpha = 1.0;
//    } else {
//        toolTip.alpha = 0.0;
//    }
//    [UIView commitAnimations];
//}

//
//- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    if (self.showTooltip) {
//        // Update the tooltip as slider knob is being moved
//        [self updateToolTipView];
//    }
//    return [super continueTrackingWithTouch:touch withEvent:event];
//}
//
//- (void)cancelTrackingWithEvent:(UIEvent *)event {
//    [super cancelTrackingWithEvent:event];
//}
//
//- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
//    if (self.showTooltip) {
//        // Fade out the tooltip view on mouse release event
//        [self animateToolTipFading:NO];
//        [super endTrackingWithTouch:touch withEvent:event];
//    }
//    if (self.isTickType) {
//        // to make the knob snap to the nearest tick mark.
//        float newStep = roundf((self.value) / stepValue);
//        self.value = newStep * stepValue;
//        [self updateToolTipView];
//    }
//}
