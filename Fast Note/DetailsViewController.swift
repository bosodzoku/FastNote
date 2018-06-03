//
//  DetailsViewController.swift
//  Fast Note
//
//  Created by Peter Iontsev on 6/3/18.
//  Copyright © 2018 Peter Iontsev. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    var previousVC = NoteTableViewController()
    var selectedNote: Notes?
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func completeButton(_ sender: UIButton) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let theFastNote = selectedNote {
                context.delete(theFastNote)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsLabel.text = selectedNote?.name
        timeLabel.text = selectedNote?.date
    }
}
