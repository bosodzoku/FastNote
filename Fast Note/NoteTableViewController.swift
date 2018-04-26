//
//  NoteTableViewController.swift
//  Fast Note
//
//  Created by Peter Iontsev on 4/24/18.
//  Copyright © 2018 Peter Iontsev. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    var fastNotes: [Notes] = []
    var selectedNote: Notes?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    override func viewWillAppear (_ animated: Bool) {
        getFNs()
    }
    //fetching from CoreData
    func getFNs() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataFNs = try? context.fetch(Notes.fetchRequest()) as? [Notes] {
                if let cdFNs = coreDataFNs {
                    fastNotes = cdFNs
                    tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fastNotes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let fastNote = fastNotes[indexPath.row]
        if let name = fastNote.name {
            if fastNote.important {
                cell.textLabel?.text = " ❗️ " + name
                cell.detailTextLabel?.text = fastNote.date
            } else {
                cell.textLabel?.text = fastNote.name
                cell.detailTextLabel?.text = fastNote.date
            }
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addVC = segue.destination as! AddViewController
        addVC.targetVC = self
    }
    //this is for deleting cells as well as entities from CoreData DB
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(fastNotes[indexPath.row])
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
                getFNs()
            }
        }
    }
}
























