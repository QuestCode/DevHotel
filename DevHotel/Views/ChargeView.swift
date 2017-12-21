//
//  ChargeView.swift
//  DevHotel
//
//  Created by Devontae Reid on 12/20/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

class ChargeView: UIView {
    
    private let nightLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate-Bold", size: 26, text: "Number of Nights")
        return label
    }()
    
    let numberOfNighstLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate", size: 18, text: "")
        return label
    }()
    
    private let roomLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate-Bold", size: 26, text: "Room Type")
        return label
    }()
    
    let roomTypeLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate", size: 18, text: "")
        return label
    }()

    let roomPriceLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate", size: 18, text: "")
        return label
    }()
    
    private let wifiLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate-Bold", size: 26, text: "Wi-Fi")
        return label
    }()
    
    let wifiUsageLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate", size: 18, text: "")
        return label
    }()
    
    let wifiPriceLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate", size: 18, text: "")
        return label
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate-Bold", size: 26, text: "Total")
        return label
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.labelWithFont(font: "Copperplate-Bold", size: 18, text: "")
        return label
    }()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        backgroundColor = .white
        
        addSubview(nightLabel)
        addSubview(numberOfNighstLabel)
        addSubview(roomLabel)
        addSubview(roomTypeLabel)
        addSubview(roomPriceLabel)
        addSubview(wifiLabel)
        addSubview(wifiPriceLabel)
        addSubview(wifiUsageLabel)
        addSubview(totalLabel)
        addSubview(totalPriceLabel)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: nightLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: roomLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: wifiLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0]", views: totalLabel)
        
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: numberOfNighstLabel)
        addConstraintsWithFormat(format: "H:[v0]-30-[v1(70)]-10-|", views: roomTypeLabel,roomPriceLabel)
        addConstraintsWithFormat(format: "H:[v0]-30-[v1(70)]-10-|", views: wifiUsageLabel,wifiPriceLabel)
        addConstraintsWithFormat(format: "H:[v0]-10-|", views: totalPriceLabel)
        
        
        addConstraintsWithFormat(format: "V:|-50-[v0]-20-[v1]", views: roomTypeLabel,wifiUsageLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0]-20-[v1]-20-[v2]-20-[v3]", views: nightLabel,roomLabel,wifiLabel,totalLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0]-20-[v1]-20-[v2]-20-[v3]", views: numberOfNighstLabel,roomPriceLabel,wifiPriceLabel,totalPriceLabel)
        
        
    }

}
