//
//  RangeSlider.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 03.11.2023.
//

import UIKit

final class RangeSlider: UIControl {
    
    let thumbWidth: CGFloat = 32

    private var previousLocation = CGPoint()
    
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerThumbLayer = RangeSliderThumbLayer()
    private let upperThumbLayer = RangeSliderThumbLayer()
    
    // MARK: - Values range
    private var minimumValue: Double = 0 {
        willSet(newValue) {
            assert(newValue < maximumValue, "RangeSlider: minimumValue should be lower than maximumValue")
        }
        didSet {
            updateLayerFrames()
        }
    }
    
    private var maximumValue: Double = 1 {
        willSet(newValue) {
            assert(newValue > minimumValue, "RangeSlider: maximumValue should be greater than minimumValue")
        }
        didSet {
            updateLayerFrames()
        }
    }
    
    private var _lowerValue: Double = 0 {
        didSet {
            if _lowerValue < minimumValue {
                _lowerValue = minimumValue
            }
            lowerValue = Int(_lowerValue)
            updateLayerFrames()
        }
    }
    
    private var _upperValue: Double = 1 {
        didSet {
            if _upperValue > maximumValue {
                _upperValue = maximumValue
            }
            upperValue = Int(_upperValue) + 1
            updateLayerFrames()
        }
    }
    
    var lowerValue: Int = 0
    var upperValue: Int = 1
    
    // MARK: - Set values range
    func setBorderlineValues(min: Int, max: Int) {
        assert(min < max, "RangeSlider: maximumValue should be greater than minimumValue")
        assert((max - min) > 1, "RangeSlider: maximumValue should be greater more than one by minimumValue")
        maximumValue = Double(max - 1)
        minimumValue = Double(min)
    }
    
    func setSelectedValues(min: Int, max: Int) {
        _upperValue = Double(max - 1)
        _lowerValue = Double(min)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeLayers()
    }
    
    override func layoutSublayers(of: CALayer) {
        super.layoutSublayers(of:layer)
        updateLayerFrames()
    }
    
    fileprivate func initializeLayers() {
        layer.backgroundColor = UIColor.clear.cgColor
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        lowerThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(lowerThumbLayer)
        upperThumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(upperThumbLayer)
    }
    
    func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        let lowerThumbCenter = CGFloat(positionForValue(_lowerValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter , y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        lowerThumbLayer.text = "\(lowerValue)"
        let upperThumbCenter = CGFloat(positionForValue(_upperValue)) + thumbWidth
        upperThumbLayer.frame = CGRect(x: upperThumbCenter , y: 0.0, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        upperThumbLayer.text = "\(upperValue)"
        trackLayer.frame = .init(x: 0, y: (bounds.height / 2) - 2, width: bounds.width, height: 4)
        trackLayer.lowerValuePosition = lowerThumbCenter
        trackLayer.upperValuePosition = upperThumbCenter
        trackLayer.setNeedsDisplay()
        CATransaction.commit()
    }
    
    private func positionForValue(_ value: Double) -> Double {
        return Double(bounds.width - 2 * thumbWidth) * (value - minimumValue) / (maximumValue - minimumValue)
    }
    
    private func boundValue(_ value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    // MARK: - Touches
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - 2 * thumbWidth)
        previousLocation = location
        if lowerThumbLayer.highlighted {
            _lowerValue = boundValue(_lowerValue + deltaValue, toLowerValue: minimumValue, upperValue: _upperValue)
        } else if upperThumbLayer.highlighted {
            _upperValue = boundValue(_upperValue + deltaValue, toLowerValue: _lowerValue, upperValue: maximumValue)
        }
        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
    
}
