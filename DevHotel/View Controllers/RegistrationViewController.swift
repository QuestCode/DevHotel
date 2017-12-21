//
//  ViewController.swift
//  Dev Hotel
//
//  Created by Devontae Reid on 12/18/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//


// Need to design tableviews

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
        self.tableView.register(RegistrationsTableViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.separatorColor = UIColor(rgb: 0x39b6d6)
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RegistrationsTableViewCell
        
        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.guestNameLabel.text = registration.firstName + " " + registration.lastName
        cell.dateLabel.text = "Date: " + dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate)
        cell.roomTypeLabel.text = "Room Type: " + registration.roomType.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = ChargesTableViewController()
        dvc.registration = registrations[indexPath.row]
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}


class RegistrationsTableViewCell: UITableViewCell {
    
    let guestNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 24)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        return label
    }()
    
    let roomTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(guestNameLabel)
        addSubview(dateLabel)
        addSubview(roomTypeLabel)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]|", views: guestNameLabel)
        addConstraintsWithFormat(format: "V:|[v0]-30-|", views: guestNameLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0][v1]-10-|", views: dateLabel,roomTypeLabel)
        addConstraintsWithFormat(format: "V:[v0]-10-|", views: dateLabel)
        addConstraintsWithFormat(format: "V:[v0]-10-|", views: roomTypeLabel)
    }
}

