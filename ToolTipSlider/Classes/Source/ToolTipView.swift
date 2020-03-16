//
//  ToolTipView.swift
//  Pods
//
//  Created by Masroor Mac on 13/03/2020.
//

import UIKit

class ToolTipView: UIView {
    var font : UIFont = UIFont.systemFont(ofSize: 12.0)
    private var valueString  : NSString   = ""
    private var value        : Int      = 0
    var toolTipBackgroundColor  = UIColor(displayP3Red: 118.0/255.0, green: 186.0/255.0, blue: 207.0/255.0, alpha: 1.0)
    var valueColor              = UIColor.white
    var toolTipRadius           = CGFloat(3.0)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        toolTipBackgroundColor.setFill()
        let roundedRect = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height * 0.7)
        let roundedRectPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: toolTipRadius)
        // Create arrow path
        let arrowPath = UIBezierPath()
        let midX = self.bounds.midX
        let midPoint = CGPoint(x: midX, y: self.bounds.maxY)
        arrowPath.move(to: midPoint)
        arrowPath.addLine(to: CGPoint.init(x: midX - 10, y: roundedRect.maxY))
        arrowPath.addLine(to: CGPoint.init(x: midX + 10, y: roundedRect.maxY))
        arrowPath.close()
        
        roundedRectPath.append(arrowPath)
        roundedRectPath.fill()
        
        if valueString != "" {
            valueColor.set()
            let textSize = valueString.size(withAttributes: [NSAttributedString.Key.foregroundColor : self.valueColor , NSAttributedString.Key.font : self.font])
            let yOffset = (roundedRect.size.height - textSize.height) / 2.0
            let textRect = CGRect(x: roundedRect.origin.x, y: yOffset, width: roundedRect.size.width, height: textSize.height)
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byWordWrapping
            style.alignment = .center
            valueString.draw(in: textRect, withAttributes: [NSAttributedString.Key.font : self.font , NSAttributedString.Key.paragraphStyle : style , NSAttributedString.Key.foregroundColor : self.valueColor])
        }
        
    }
    
    func updateValue(value : Int){
        self.value = value
        self.valueString = NSString(string: "\(value)")
        self.setNeedsDisplay()
    }
    
}
