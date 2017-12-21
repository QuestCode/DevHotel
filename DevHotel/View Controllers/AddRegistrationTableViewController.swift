//
//  AddRegistrationTableViewController.swift
//  DevHotel
//
//  Created by Devontae Reid on 12/18/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

protocol AddRegistrationTableViewControllerDelegate {
    func didAddRegistration(registration: Registration)
}

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    // This is used to pass data back VC
    var delegate: AddRegistrationTableViewControllerDelegate?
    
    let firstNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "First Name"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let lastNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Last Name"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let checkInDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkOutDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkInDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let checkOutDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let numberOfAdultsLabel:UILabel = {
        let label = UILabel()
        label.text = "Adults"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfChildrenLabel:UILabel = {
        let label = UILabel()
        label.text = "Children"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfAdultsStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.tintColor = UIColor(rgb: 0x39b6d6)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    let numberOfChildrenStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.tintColor = UIColor(rgb: 0x39b6d6)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    let wifiSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.tintColor = UIColor(rgb: 0x39b6d6)
        switcher.onTintColor = UIColor(rgb: 0x39b6d6)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    let wifiLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 10"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let roomTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var roomType: RoomType?
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numOfAdults = Int(numberOfAdultsStepper.value)
        let numOfChildren = Int(numberOfChildrenStepper.value)
        let wifiWanted = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, email: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numOfAdults, numberOfChildren: numOfChildren, roomType: roomType, wifi: wifiWanted)
        
    }
    
    // MARK: INDEX PATHS
    let firstNameCellIndexPath = IndexPath(row: 1, section: 0)
    let lastNameCellIndexPath = IndexPath(row: 2, section: 0)
    let emailCellIndexPath = IndexPath(row: 3, section: 0)

    let checkInLabelIndexPath = IndexPath(row: 1, section: 1)
    let checkOutLabelIndexPath = IndexPath(row: 3, section: 1)
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 4, section: 1)
    
    let adultsIndexPath = IndexPath(row: 1, section: 2)
    let childrenIndexPath = IndexPath(row: 2, section: 2)
    
    let wifiIndexPath = IndexPath(row: 1, section: 3)
    let roomTypeIndexPath = IndexPath(row: 1, section: 4)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet{
            checkInDatePicker.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet{
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "New Guest Registration"
        
        setUpViews()
        
        updateDateViews()
        updateNumberOfGuest()
        updateRoomType()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkOutDatePicker.date = midnightToday
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(_:)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpViews() {
        self.tableView.backgroundColor = UIColor(displayP3Red: 215/255, green: 222/255, blue: 232/255, alpha: 1.0)
        checkInDatePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        checkOutDatePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        numberOfAdultsStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        numberOfChildrenStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    
    func updateDateViews()  {
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
    
    func updateNumberOfGuest() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuest()
    }
    
    func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    // Implementation of doneButtonTapped
    // Need to pass data backward VC
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        if let registration = registration {
            delegate?.didAddRegistration(registration: registration)
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section,indexPath.row) {
        case (checkInDatePickerCellIndexPath.section,checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case (checkOutDatePickerCellIndexPath.section,checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 46.0
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return 4
        case 1:
            return 5
        case 2:
            return 3
        case 3:
            return 2
        case 4:
            return 2
        default:
            return 0
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        
        switch (indexPath.section,indexPath.row) {
        case (firstNameCellIndexPath.section,firstNameCellIndexPath.row):
            // Add First Name TextField
            cell.addSubview(firstNameTextField)
            cell.addConstraintsWithFormat(format: "H:|-20-[v0]-5-|", views: firstNameTextField)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: firstNameTextField)
            break
        case (lastNameCellIndexPath.section,lastNameCellIndexPath.row):
            // Add Last Name TextField
            cell.addSubview(lastNameTextField)
            cell.addConstraintsWithFormat(format: "H:|-20-[v0]-5-|", views: lastNameTextField)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: lastNameTextField)
            break
        case (emailCellIndexPath.section,emailCellIndexPath.row):
            // Add Email TextField
            cell.addSubview(emailTextField)
            cell.addConstraintsWithFormat(format: "H:|-20-[v0]-5-|", views: emailTextField)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: emailTextField)
            break
        case (checkInLabelIndexPath.section,checkInLabelIndexPath.row):
            // Add Check-In-Label
            cell.textLabel?.text = "Check-In-Date"
            cell.addSubview(checkInDateLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-15-|", views: checkInDateLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: checkInDateLabel)
            break
        case (checkOutLabelIndexPath.section,checkOutLabelIndexPath.row):
            // Add Check-In-Label
            cell.textLabel?.text = "Check-Out-Date"
            cell.addSubview(checkOutDateLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-15-|", views: checkOutDateLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: checkOutDateLabel)
            break
        case (checkInDatePickerCellIndexPath.section,checkInDatePickerCellIndexPath.row):
            // Add Check-In Date Picker
            cell.addSubview(checkInDatePicker)
            cell.addConstraintsWithFormat(format: "H:|-20-[v0]-5-|", views: checkInDatePicker)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: checkInDatePicker)
            break
        case (checkOutDatePickerCellIndexPath.section,checkOutDatePickerCellIndexPath.row):
            // Add Check-Out Date Picker
            cell.addSubview(checkOutDatePicker)
            cell.addConstraintsWithFormat(format: "H:|-20-[v0]-5-|", views: checkOutDatePicker)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: checkOutDatePicker)
            break
        case (adultsIndexPath.section,adultsIndexPath.row):
            // Add Adult Row
            cell.textLabel?.text = "Adults"
            cell.addSubview(numberOfAdultsLabel)
            cell.addSubview(numberOfAdultsStepper)
            cell.addConstraintsWithFormat(format: "H:[v0]-5-[v1]-10-|", views: numberOfAdultsLabel,numberOfAdultsStepper)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: numberOfAdultsLabel)
            cell.addConstraintsWithFormat(format: "V:|-10-[v0]-5-|", views: numberOfAdultsStepper)
            break
        case (childrenIndexPath.section,childrenIndexPath.row):
            // Add Children Row
            cell.textLabel?.text = "Children"
            cell.addSubview(numberOfChildrenLabel)
            cell.addSubview(numberOfChildrenStepper)
            cell.addConstraintsWithFormat(format: "H:[v0]-5-[v1]-10-|", views: numberOfChildrenLabel,numberOfChildrenStepper)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: numberOfChildrenLabel)
            cell.addConstraintsWithFormat(format: "V:|-10-[v0]-5-|", views: numberOfChildrenStepper)
            break
        case (wifiIndexPath.section,wifiIndexPath.row):
            // Add Wifi Label
            cell.textLabel?.text = "Wi-Fi (per day)"
            cell.addSubview(wifiLabel)
            cell.addSubview(wifiSwitch)
            cell.addConstraintsWithFormat(format: "H:[v0]-15-[v1]-10-|", views: wifiLabel,wifiSwitch)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: wifiLabel)
            cell.addConstraintsWithFormat(format: "V:|-10-[v0]-5-|", views: wifiSwitch)
            break
        case (roomTypeIndexPath.section,roomTypeIndexPath.row):
            // Add Room Type
            cell.textLabel?.text = "Room Type"
            cell.addSubview(roomTypeLabel)
            cell.addConstraintsWithFormat(format: "H:[v0]-30-|", views: roomTypeLabel)
            cell.addConstraintsWithFormat(format: "V:|[v0]|", views: roomTypeLabel)
            break
        default:
            cell.backgroundColor = UIColor(displayP3Red: 215/255, green: 222/255, blue: 232/255, alpha: 1.0)
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
            break
        }
        

        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section,indexPath.row) {
        case (checkInLabelIndexPath.section,checkInLabelIndexPath.row):
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            break
        case (checkOutLabelIndexPath.section,checkOutLabelIndexPath.row):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
                isCheckOutDatePickerShown = true
            } else {
                isCheckOutDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            break
        case (roomTypeIndexPath.section,roomTypeIndexPath.row):
            let dvc = SelectRoomTableViewController()
            dvc.delegate = self
            dvc.roomType = roomType
            self.navigationController?.pushViewController(dvc, animated: true)
        default:
            break
        }
    }


}
