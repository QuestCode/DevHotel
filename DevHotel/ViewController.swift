//
//  ViewController.swift
//  Dev Hotel
//
//  Created by Devontae Reid on 12/18/17.
//  Copyright © 2017 Devontae Reid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let firstNameTextField: UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    let lastNameTextField: UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    let checkInDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let checkOutDateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let checkInDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    
    let checkOutDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkOutDatePicker.date = midnightToday
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateDateViews()  {
        
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(86400)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    
    func doneButtonTapped(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
    }
    
    
}

