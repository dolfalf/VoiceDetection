//
//  DetectionCircleView.swift
//  VoiceDetection
//
//  Created by jaeeun on 2020/04/23.
//  Copyright © 2020 archive-asia. All rights reserved.
//

import UIKit

class DetectionCircleView: UIView {

    var centerImageView = UIImageView(frame: .zero)
    
    var circleLayer = CALayer()
    var lLayer = CAShapeLayer()
    var rLayer = CAShapeLayer()
    
    var detectLavel = CGFloat(0) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        
        backgroundColor = .clear
        
        centerImageView.image = UIImage(named: "jangga")
        centerImageView.layer.masksToBounds = true
        addSubview(centerImageView)
        
        layer.addSublayer(lLayer)
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        drawGrayCirlcle()
        drawLevelMeter(level: detectLavel)
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
        
        let circleLineWidth = CGFloat(20)
        let circleSize = CGFloat(bounds.width/2 - circleLineWidth/2)
        
        let grayPath = UIBezierPath()
        grayPath.addArc(withCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), // 中心
                     radius: circleSize, // 半径
                     startAngle: 0, // 開始角度
                     endAngle: .pi * 2.0, // 終了角度
                     clockwise: true) // 時計回り

        let grayLayer = CAShapeLayer()
        grayLayer.path = grayPath.cgPath
        grayLayer.fillColor = UIColor.clear.cgColor // 塗り色
        grayLayer.strokeColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor // 線の色
        grayLayer.lineWidth = circleLineWidth // 線の幅
        layer.addSublayer(grayLayer)
    }
    
    func drawLevelMeter(level: CGFloat) {
        
        
        
        //0.5 ~ 1
        let startLevel = CGFloat(0.5)
        
        let circleLineWidth = CGFloat(20)
        let circleSize = CGFloat(bounds.width/2 - circleLineWidth/2)
        
        let leftPath = UIBezierPath()
        leftPath.addArc(withCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), // 中心
                    radius: circleSize, // 半径
            startAngle: .pi * startLevel, // 開始角度
            endAngle: .pi * (startLevel + level), // 終了角度
                    clockwise: true) // 時計回り

        lLayer.removeFromSuperlayer()
        lLayer = CAShapeLayer()
        layer.addSublayer(lLayer)
        lLayer.path = leftPath.cgPath
        lLayer.fillColor = UIColor.clear.cgColor // 塗り色
        lLayer.strokeColor = UIColor.orange.cgColor // 線の色
        lLayer.lineCap = .round
        lLayer.lineWidth = circleLineWidth // 線の幅
        
        
        let rightPath = UIBezierPath()
        rightPath.addArc(withCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), // 中心
                    radius: circleSize, // 半径
            startAngle: .pi * startLevel, // 開始角度
                    endAngle: .pi * (startLevel - level), // 終了角度
                    clockwise: false) // 時計回り

        rLayer.removeFromSuperlayer()
        rLayer = CAShapeLayer()
        layer.addSublayer(rLayer)
        rLayer.frame = bounds
        rLayer.path = rightPath.cgPath
        rLayer.fillColor = UIColor.clear.cgColor // 塗り色
        rLayer.strokeColor = UIColor.orange.cgColor // 線の色
        
        if level < 1 {
            rLayer.lineCap = .round
        }
        rLayer.lineWidth = circleLineWidth // 線の幅
        
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.duration = 0.3
//        animation.fromValue = 0.9
//        animation.toValue = 1.0
//        animation.timingFunction = CAMediaTimingFunction(name: .linear)
//        animation.fillMode = .forwards
//        animation.isRemovedOnCompletion = false
//        rLayer.add(animation, forKey: animation.keyPath)
    }
}
