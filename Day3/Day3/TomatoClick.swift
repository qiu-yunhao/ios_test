//
//  TomatoClick.swift
//  Day3
//
//  Created by hello on 2022/7/13.
//

import UIKit

class TomatoClick: UIView {
    private var _timeTotal : Int = 0
    var timeTotal : Int {
        get {
            return _timeTotal
        }
        
        set {
            _timeTotal = newValue
            time = newValue
            setNeedsDisplay()
        }
    }
    private var time : Int = 0
    
    private var _font : UIFont = .systemFont(ofSize: 12)
    var font : UIFont {
        get {
            return _font
        }
        set {
            _font = newValue
            setNeedsDisplay()
        }
    }
    
    private var _textColor : UIColor = .black
    var textColor : UIColor {
        get {
            return _textColor
        }
        
        set {
            _textColor = newValue
            setNeedsDisplay()
        }
    }
    
    private var _strokeColor : UIColor = .blue
    var strokeColor : UIColor {
        get {
            return _strokeColor
        }
        
        set {
            _strokeColor = newValue
            setNeedsDisplay()
        }
    }
    
    private var label : UILabel = UILabel()
    
    private var radius : Float = 100
    
    private let canvas  = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        initView()
    }
    
    private func initView(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.6),
            label.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.6)
        ])
        canvas.strokeColor = strokeColor.cgColor
        canvas.fillColor = UIColor.clear.cgColor
        canvas.strokeStart = 0
        canvas.lineWidth = 3
        self.layer.addSublayer(canvas)
    }
    
    override func draw(_ rect: CGRect) {
        radius = Float((self.bounds.width - 30) / 2)
        label.font = font
        label.textColor = textColor
        label.text = String(format: "%02d:%02d:%02d", time / 3600, (time / 60) % 60 , time % 60)
        canvas.path = UIBezierPath(arcCenter: label.center, radius: CGFloat(radius), startAngle: -0.5 * Double.pi, endAngle:1.5 * Double.pi, clockwise: true).cgPath
        canvas.strokeEnd = CGFloat(Float(timeTotal - time) / Float(timeTotal))
        
    }
    
    func startCountDown(){
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(cutDown(sender:)), userInfo: nil, repeats: true)
    }
    
    @objc private func cutDown(sender : Timer){
        if time > 0 {
            time -= 1
            setNeedsDisplay()
        }else {
            sender.invalidate()
        }
    }
}

