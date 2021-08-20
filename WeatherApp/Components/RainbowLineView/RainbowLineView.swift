//
//  RainbowLineView.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 20.08.21.
//

import UIKit

class RainbowLineView: UIView {
    
    init(width: CGFloat, colors: [UIColor]) {
        super.init(frame: .zero)
        setup(width: width, colors: colors)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView, color: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.lineDashPattern = [2, 6]
        shapeLayer.lineCap = .round
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
}

// MARK: Public Interface
extension RainbowLineView {
    
    func setup(width: CGFloat, colors: [UIColor]) {
        let segmentLength = width / CGFloat(colors.count)
        var startX: CGFloat = 0.0
        var endX: CGFloat = segmentLength
        colors.forEach { (color) in
            drawDottedLine(
                start: CGPoint(x: startX, y: .zero),
                end: CGPoint(x: endX, y: .zero),
                view: self,
                color: color
            )
            startX += segmentLength
            endX += segmentLength
        }
    }
    
    func reset() {
        self.layer.sublayers?.removeAll()
    }
    
}
