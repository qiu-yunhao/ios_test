//
//  ViewController.swift
//  Day2
//
//  Created by hello on 2022/7/11.
//

import UIKit

class ViewController: UIViewController {
    
    let color : [UIColor] = [ .red, .yellow, .blue, .green]
    
    let tab : UISegmentedControl = {
        let tab = UISegmentedControl(items: ["red","yellow","blue","green"])
        tab.translatesAutoresizingMaskIntoConstraints = false
        return tab
    }()
    let button : UIButton = {
        let button  = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tab)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            tab.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            tab.heightAnchor.constraint(equalToConstant: 50),
            tab.widthAnchor.constraint(equalTo: view.widthAnchor , multiplier: 0.8),
            tab.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            button.heightAnchor.constraint(equalTo : button.widthAnchor)
           
        ])
        button.layer.cornerRadius = view.bounds.width*0.3
        button.isUserInteractionEnabled = true
        handleDifferenceTap()
        
        tab.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        tab.selectedSegmentIndex = 0
        
    }

    @objc func segmentValueChanged(sender : UISegmentedControl!){
        button.backgroundColor = color[sender.selectedSegmentIndex]
    }
    
    private func handleDifferenceTap(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(show1))
        tap1.numberOfTapsRequired = 1
        button.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(show2(sender:)))
        tap2.numberOfTapsRequired = 2
        button.addGestureRecognizer(tap2)
        
        let tap3 = UILongPressGestureRecognizer(target: self, action: #selector(show3))
        tap3.minimumPressDuration = 1 //感觉加1之后间隔明显变长
        button.addGestureRecognizer(tap3)
        
        
        let tap4 = UIPinchGestureRecognizer(target: self, action: #selector(show4(sender:)))
        button.addGestureRecognizer(tap4)
        
        let tap5 = UIRotationGestureRecognizer(target: self, action: #selector(show5(sender:)))
        button.addGestureRecognizer(tap5)
        
    }
    
    
    //一次点击后弹出提示
    @objc func show1( sender : UITapGestureRecognizer){
        showToast(message: "点击一次", time: 1.5)
    }
    
    //2次点击按钮后抖动
    @objc func show2( sender : UITapGestureRecognizer){
        
        button.shake(withDuration: 0.1, times: 4, offset: 10)
        /**
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            UIView.modifyAnimations(withRepeatCount: 4, autoreverses: true, animations: {
                    //顺序执行？
                self.button.transform = CGAffineTransform.identity.rotated(by: Double.pi/10).translatedBy(x: CGFloat(arc4random_uniform(20) + 1), y: -CGFloat(arc4random_uniform(20) + 1))
            })
        }, completion: { ( isComplete ) in
                           self.button.transform = CGAffineTransform.identity
        })
         */
    }
    
    //长按后拖动,动画实现的有点蠢
    @objc func show3( longPress : UILongPressGestureRecognizer){
        showToast(message: "进入拖动状态", time: 1.5)
        
        if(longPress.state == .changed){
            let point = longPress.location(in: view)
            let cur = button.center
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.button.transform = CGAffineTransform.identity.translatedBy(x: point.x - cur.x, y: point.y - cur.y)
            }, completion: nil)
        }
        
    }
    
    //放大手势实现放大
    @objc func show4(sender : UIPinchGestureRecognizer) {
        let fit = sender.scale
        button.transform = CGAffineTransform.identity.scaledBy(x: fit, y: fit)

    }
    
    //实现旋转
    @objc func show5(sender : UIRotationGestureRecognizer) {
        let r = sender.rotation
        button.transform = CGAffineTransform.identity.rotated(by: r)
    }
        
}

extension ViewController {
    func showToast(message : String , time : Double){
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.textColor = .white
        label.backgroundColor = .black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.bottomAnchor,constant: -50 ),
            label.heightAnchor.constraint(equalToConstant: 25),
            label.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.6)
        ])
        
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            label.alpha = 0
        }, completion: { (isComplete) in
            label.removeFromSuperview()
        })
    }
}

extension UIView{
    
    /// 实现水平抖动效果
    /// - Parameters:
    ///   - withDuration: 单次动画持续时间
    ///   - times: 动画持续次数
    ///   - offset: 抖动偏移量
    func shake(withDuration : Double , times : Int , offset : CGFloat){
        UIView.animate(withDuration: withDuration, delay: 0, options: .curveLinear, animations: {
            self.layer.setAffineTransform(CGAffineTransform(translationX: offset, y: 0))
        }, completion: { (isComplete) in
            if times == 0 {
                self.layer.setAffineTransform(CGAffineTransform.identity)
            } else {
                self.shake(withDuration: withDuration, times: times - 1, offset: -offset )
            }
            
        })
            
        
    }
}

