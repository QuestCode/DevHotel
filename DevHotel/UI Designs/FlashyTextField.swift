//
//  FlashyTextField.swift
//  DevHotel
//
//  Created by Devontae Reid on 12/20/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

class FlashyTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var leftImageView: UIImageView? = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        if (leftImageView?.image) == nil {
            leftViewMode = .always
            
            
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(leftImageView!)
            
            view.addConstraintsWithFormat(format: "H:|-5-[v0(25)]", views: leftImageView!)
            view.addConstraintsWithFormat(format: "V:|[v0(25)]", views: leftImageView!)
            
            addSubview(view)
            addConstraintsWithFormat(format: "H:|[v0(40)]", views: view)
            addConstraintsWithFormat(format: "V:|[v0(25)]", views: view)
            
            leftView = view
            
        } else {
            leftViewMode = .never
        }
    }
    
    func placeholderWithColor(placeholder: String,color: UIColor) {
        let attr = [
            NSAttributedStringKey.foregroundColor: color,
            NSAttributedStringKey.font : UIFont(name: "AppleSDGothicNeo-Regular", size: 20)!
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attr)
    }
    
}
