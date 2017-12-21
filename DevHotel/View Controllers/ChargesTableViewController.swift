//
//  ChargesTableViewController.swift
//  DevHotel
//
//  Created by Devontae Reid on 12/20/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

class ChargesTableViewController: UITableViewController {
    
    var registration: Registration?
    let cellId = "chargesCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Charges"
        label.textAlignment = .center
        label.font = UIFont(name: "Copperplate", size: 20)
        return label
    }()
    
    let numOfNightsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Copperplate", size: 20)
        return label
    }()
    
    let roomTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Copperplate", size: 20)
        return label
    }()
    
    let roomPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Copperplate", size: 20)
        return label
    }()
    
    let wifiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Copperplate", size: 20)
        return label
    }()
    
    let wifiPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Copperplate", size: 20)
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Copperplate", size: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.separatorColor = .clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        let components = Calendar.current.dateComponents([.day], from: (registration?.checkInDate)!, to: (registration?.checkOutDate)!)
        let roomPrice = (registration?.roomType.price)! * components.day!
        cell.textLabel?.font = UIFont(name: "Copperplate-Bold", size: 20)
        
        
        var wifiPrice = 0
        
        if (registration?.wifi)! {
            wifiPrice = 10 * components.day!
            wifiLabel.text = "Yes"
        } else {
            wifiLabel.text = "No"
        }
        let totalPrice = roomPrice + wifiPrice
        
        switch indexPath.row {
        case 0:
            cell.addSubview(titleLabel)
            cell.addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: titleLabel)
            break
        case 1:
            cell.addSubview(numOfNightsLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-10-|", views: numOfNightsLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: numOfNightsLabel)
            numOfNightsLabel.text = "\(components.day!)"
            cell.textLabel?.text = "Number of Nights"
            break
        case 2:
            cell.addSubview(roomTypeLabel)
            cell.addSubview(roomPriceLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-30-[v1(100)]-10-|", views: roomTypeLabel,roomPriceLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: roomTypeLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: roomPriceLabel)
            let shortName = (registration?.roomType)!.shortName
            roomPriceLabel.text = "$ \(roomPrice)"
            roomTypeLabel.text = "\(shortName)"
            cell.textLabel?.text = "Room Type"
            break
        case 3:
            cell.addSubview(wifiLabel)
            cell.addSubview(wifiPriceLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-30-[v1(100)]-10-|", views: wifiLabel,wifiPriceLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: wifiLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: wifiPriceLabel)
            wifiPriceLabel.text = "$ \(wifiPrice)"
            cell.textLabel?.text = "Wifi"
            break
        case 4:
            cell.addSubview(totalLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-10-|", views: totalLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: totalLabel)
            totalLabel.text = "$ \(totalPrice)"
            cell.textLabel?.text = "Total"
            break
        default: break
        }

        return cell
    }


}
