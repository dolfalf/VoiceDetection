//
//  DetectionCircleView.swift
//  VoiceDetection
//
//  Created by jaeeun on 2020/04/23.
//  Copyright © 2020 archive-asia. All rights reserved.
//

import UIKit

class DetectionCircleView: UIView {

    var detectLevel = CGFloat(0) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var centerImage: UIImage? {
        didSet {
            centerImageView.image = centerImage
        }
    }
    
    var circleBackgroundColor = UIColor.lightGray
    var levelLineColor = UIColor.orange
    
    private var centerImageView = UIImageView(frame: .zero)
    
    private var circleLayer = CALayer()
    private var lLayer = CAShapeLayer()
    private var rLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        
        backgroundColor = .clear
        centerImageView.image = centerImage
        centerImageView.layer.masksToBounds = true
        addSubview(centerImageView)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        drawGrayCirlcle()
        drawLevelMeter(level: detectLevel)
    }
    
    override func layoutSubviews() {
        //adjust layout
        setCenterImageLayout()
    }

    func setCenterImageLayout() {
        
        let centerRate = CGFloat(0.7)
        
        centerImageView.frame = CGRect(origin: .zero,
                                       size: CGSize(width: bounds.width * centerRate,
                                                    height: bounds.height * centerRate))
            
        centerImageView.layer.cornerRadius = centerImageView.bounds.width / 2
        
        
        centerImageView.frame = CGRect(origin: CGPoint(x: bounds.width/2 - centerImageView.bounds.width/2,
                                                       y: bounds.height/2 - centerImageView.bounds.height/2),
                                       size: centerImageView.bounds.size)
    }
    
    func drawGrayCirlcle() {
        
        let circleLineWidth = CGFloat(bounds.width * 0.1)
        let circleSize = CGFloat(bounds.width/2 - circleLineWidth/2)
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: bounds.width/2, y: bounds.height/2),
                    radius: circleSize,
                    startAngle: 0,
                    endAngle: .pi * 2.0,
                    clockwise: true)

        let circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = circleBackgroundColor.cgColor
        circleLayer.lineWidth = circleLineWidth // 線の幅
        layer.addSublayer(circleLayer)
    }
    
    func drawLevelMeter(level: CGFloat) {
        
        let startLevel = CGFloat(0.5)   // 0
        let circleLineWidth = CGFloat(bounds.width * 0.1)
        let circleSize = CGFloat(bounds.width/2 - circleLineWidth/2)
        
        let leftPath = UIBezierPath()
        leftPath.addArc(withCenter: CGPoint(x: bounds.width/2, y: bounds.height/2),
                        radius: circleSize,
                        startAngle: .pi * startLevel,
                        endAngle: .pi * (startLevel + level),
                        clockwise: true)

        lLayer.removeFromSuperlayer()
        lLayer = CAShapeLayer()
        layer.addSublayer(lLayer)
        lLayer.path = leftPath.cgPath
        lLayer.fillColor = UIColor.clear.cgColor
        lLayer.strokeColor = levelLineColor.cgColor
        lLayer.lineWidth = circleLineWidth
        
        if level < 1 {
            lLayer.lineCap = .round
        }
        
        let rightPath = UIBezierPath()
        rightPath.addArc(withCenter: CGPoint(x: bounds.width/2, y: bounds.height/2),
                         radius: circleSize,
                         startAngle: .pi * startLevel,
                         endAngle: .pi * (startLevel - level),
                         clockwise: false)

        rLayer.removeFromSuperlayer()
        rLayer = CAShapeLayer()
        layer.addSublayer(rLayer)
        rLayer.frame = bounds
        rLayer.path = rightPath.cgPath
        rLayer.fillColor = UIColor.clear.cgColor
        rLayer.strokeColor = levelLineColor.cgColor
        rLayer.lineWidth = circleLineWidth
        
        if level < 1 {
            rLayer.lineCap = .round
        }
        
    }
}
