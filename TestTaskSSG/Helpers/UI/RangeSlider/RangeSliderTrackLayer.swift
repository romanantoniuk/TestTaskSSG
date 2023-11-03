//
//  RangeSliderTrackLayer.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 03.11.2023.
//

import UIKit

class RangeSliderTrackLayer: CALayer {
        
    var lowerValuePosition: CGFloat = 0
    var upperValuePosition: CGFloat = 0
    
    override func draw(in ctx: CGContext) {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 2)
        ctx.addPath(path.cgPath)
        ctx.setFillColor(AppColor.backgroundSlider.cgColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()
        ctx.setFillColor(AppColor.backgroundSliderHighlighted.cgColor)
        let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: 4)
        ctx.fill(rect)
    }
    
}
