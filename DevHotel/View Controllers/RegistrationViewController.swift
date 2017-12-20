//
//  ViewController.swift
//  Dev Hotel
//
//  Created by Devontae Reid on 12/18/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

class RegistrationViewController: UITableViewController, AddRegistrationTableViewControllerDelegate {

    let cellID = "registrationCell"
    
    var registrations = [
        Registration(firstName: "Larry", lastName: "Jones", email: "lj12@gmail.com", checkInDate: Date(), checkOutDate: Date().addingTimeInterval(TimeInterval(4*(24*60*60))), numberOfAdults: 2, numberOfChildren: 1, roomType: RoomType(id: 2, name: "Double Queen", shortName: "DQ", price: 220), wifi: true),
        Registration(firstName: "Amber", lastName: "Johnson", email: "aj1234@gmail.com", checkInDate: Date().addingTimeInterval(TimeInterval(4*(24*60*60))), checkOutDate: Date().addingTimeInterval(TimeInterval(7*(24*60*60))), numberOfAdults: 2, numberOfChildren: 1, roomType: RoomType(id: 2, name: "Double Queen", shortName: "DQ", price: 220), wifi: false),
        Registration(firstName: "Carson", lastName: "Wentz", email: "cjwentz11@gmail.com", checkInDate: Date().addingTimeInterval(TimeInterval(1*(24*60*60))), checkOutDate: Date().addingTimeInterval(TimeInterval(7*(24*60*60))), numberOfAdults: 2, numberOfChildren: 0, roomType: RoomType(id: 7, name: "Penthouse Suite", shortName: "PHS", price: 1110), wifi: true),
        Registration(firstName: "Aaron", lastName: "Rodgers", email: "ar12@gmail.com", checkInDate: Date(), checkOutDate: Date().addingTimeInterval(TimeInterval(7*(24*60*60))), numberOfAdults: 2, numberOfChildren: 0, roomType: RoomType(id: 7, name: "Penthouse Suite", shortName: "PHS", price: 1110), wifi: true)
    ]
    
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
        // Need to make destination View Controller delegate to this vc
        // This is needed to pass data backward views
        let dvc = AddRegistrationTableViewController()
        dvc.delegate = self
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func didAddRegistration(registration: Registration) {
        self.registrations.append(registration)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        
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
