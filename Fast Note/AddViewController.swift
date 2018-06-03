//
//  AddViewController.swift
//  Fast Note
//
//  Created by Peter Iontsev on 4/25/18.
//  Copyright © 2018 Peter Iontsev. All rights reserved.
//

import UIKit
import UserNotifications

class AddViewController: UIViewController {
    
    var targetVC = NoteTableViewController()
    
    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var importantSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func saveButton(_ sender: Any) {
        //Adding to coredata
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let fn = Notes(entity: Notes.entity(), insertInto: context)
            fn.name = titleTextField.text!
            fn.important = importantSwitch.isOn
            fn.date = dateToString(date: datePicker.date)
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //converting date to string to show in table cell
    func dateToString (date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    //to hide keyboard when touch out of
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}






























