//
//  PullStepper.swift
//  CustomSteppers
//
//  Created by Devontae Reid on 12/22/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

class PullStepper: UIView {

    var value: Int = 0
    var bgColor: UIColor = .black
    var roundViewColor: UIColor = .white
    var centerOfView: CGFloat = 0
    
    
    
    private let bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private let minusView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "minus_2")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        return view
    }()
    
    private let plusView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "plus_2")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        return view
    }()
    
    private let numberLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .red
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(bgColor: UIColor,roundViewColor: UIColor) {
        self.init()
        self.bgColor = bgColor
        self.roundViewColor = roundViewColor
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        updateLabel()
        
        addSubview(bgView)
        let bgWhiteView = UIView()
        bgWhiteView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(bgWhiteView)
        
        bgView.addSubview(minusView)
        bgView.addSubview(numberLabel)
        bgView.addSubview(plusView)
        bgView.bringSubview(toFront: numberLabel)
        
        
        // MARK: Constraints Section
        addContraintsWithFormat(format: "H:|[v0]|", views: bgView)
        addContraintsWithFormat(format: "V:|[v0]|", views: bgView)
        
        bgView.addContraintsWithFormat(format: "H:|[v0]|", views: bgWhiteView)
        bgView.addContraintsWithFormat(format: "V:|[v0]|", views: bgWhiteView)
        bgView.addContraintsWithFormat(format: "H:|-5-[v0(20)]-5-[v1(35)]-5-[v2(20)]-5-|", views: minusView,numberLabel,plusView)
        bgView.addContraintsWithFormat(format: "V:|-5-[v0(20)]", views: minusView)
        bgView.addContraintsWithFormat(format: "V:|[v0(35)]|", views: numberLabel)
        bgView.addContraintsWithFormat(format: "V:|-5-[v0(20)]", views: plusView)
        
        // MARK: Design Sections
        bgView.backgroundColor = bgColor
        bgView.layer.cornerRadius = 15
        
        bgWhiteView.backgroundColor = .white
        bgWhiteView.alpha = 0.2
        
        
        
        bgView.clipsToBounds = true
        minusView.tintColor = roundViewColor
        plusView.tintColor = roundViewColor
        
        numberLabel.backgroundColor = roundViewColor
        numberLabel.textColor = bgColor
        numberLabel.layer.cornerRadius = 18
        numberLabel.clipsToBounds = true
    
        
        addPanGesture(view: numberLabel)
        
        
        
    }
    
    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlerPan(sender:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(pan)
    }
    
    @objc private func handlerPan(sender: UIPanGestureRecognizer) {
        let numberView = sender.view
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: numberView!, sender: sender)
        case .ended:
            if (numberView?.frame.intersects(minusView.frame))! {
                self.decrement()
            } else if (numberView?.frame.intersects(plusView.frame))! {
                self.increment()
            }
            break
        default:
            break
        }
    }
    
    private func moveViewWithPan(view: UIView,sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: (view.center.x) + translation.x/4, y: (view.center.y))
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    private func updateLabel() {
        numberLabel.text = "\(value)"
    }
    
    @objc private func increment() {
        UIView.animate(withDuration: 0.3, animations: {
            self.value = self.value + 1
            self.numberLabel.center.x = 45
        })
        updateLabel()
    }
    
    @objc private func decrement() {
        UIView.animate(withDuration: 0.3, animations: {
            self.value = self.value - 1
            self.numberLabel.center.x = 45
        })
        updateLabel()
    }

}
