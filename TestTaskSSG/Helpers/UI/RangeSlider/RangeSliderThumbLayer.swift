//
//  RangeSliderThumbLayer.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 03.11.2023.
//

import UIKit

class RangeSliderThumbLayer: CALayer {
    
    var text: String = ""
    private var valueTextLayer: CATextLayer?
    
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init() {
        super.init()
        valueTextLayer = CATextLayer()
        valueTextLayer?.alignmentMode = .center
        valueTextLayer?.fontSize = 12
        valueTextLayer?.foregroundColor = AppColor.textLight.cgColor
        addSublayer(valueTextLayer!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        let thumbFrame: CGRect = .init(x: 0, y: 0, width: 32, height: 32)
        let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: 4)
        ctx.setFillColor(AppColor.backgroundAccent.cgColor)
        ctx.addPath(thumbPath.cgPath)
        ctx.fillPath()
        if highlighted {
            ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
            ctx.addPath(thumbPath.cgPath)
            ctx.fillPath()
        }
        if let valueTextLayer = valueTextLayer {
            valueTextLayer.string = text
            let textAttributes: [NSAttributedString.Key: Any] = [
                .font: AppFonts.medium.font(with: 12),
                .foregroundColor: AppColor.textLight,
            ]
            let attributedText = NSAttributedString(string: text, attributes: textAttributes)
            valueTextLayer.string = attributedText
            let textSize = attributedText.size()
            valueTextLayer.frame = CGRect(x: thumbFrame.minX, y: thumbFrame.midY - textSize.height / 2, width: 32, height: 32)
        }
    }
    
}

