//
//  ViewController.swift
//  Dev Hotel
//
//  Created by Devontae Reid on 12/18/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

class RegistrationViewController: UITableViewController {
    
    let cellID = "registrationCell"
    
    var registrations = [Registration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registrations"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRegistration(_:)))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addRegistration(_ : UIBarButtonItem) {
        self.navigationController?.pushViewController(AddRegistrationTableViewController(), animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = registration.firstName + " " + registration.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + ": " + registration.roomType.name
        
        return cell
    }
    
}





extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
