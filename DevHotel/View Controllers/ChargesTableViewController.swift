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
    
    let numOfNightsLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roomTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roomPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wifiLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let wifiPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Charges".uppercased()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        let components = Calendar.current.dateComponents([.day], from: (registration?.checkInDate)!, to: (registration?.checkOutDate)!)
        let roomPrice = (registration?.roomType.price)! * components.day!
        
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
            cell.addSubview(numOfNightsLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-10-|", views: numOfNightsLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: numOfNightsLabel)
            numOfNightsLabel.text = "\(components.day!)"
            cell.textLabel?.text = "Number of Nights"
            break
        case 1:
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
        case 2:
            cell.addSubview(wifiLabel)
            cell.addSubview(wifiPriceLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-30-[v1(100)]-10-|", views: wifiLabel,wifiPriceLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: wifiLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: wifiPriceLabel)
            wifiPriceLabel.text = "$ \(wifiPrice)"
            cell.textLabel?.text = "Wifi"
            break
        case 3:
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
