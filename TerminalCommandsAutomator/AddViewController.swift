//
//  AddViewController.swift
//  TerminalCommandsAutomator
//
//  Created by Jaival Bhuptani on 2020-11-19.
//

import Cocoa
import RealmSwift

class AddViewController: NSViewController {
    @IBOutlet weak var computerField: NSTextField!
    @IBOutlet weak var commandField: NSTextField!
    
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func addRow(_ sender: NSButton) {
        if let cf = computerField?.stringValue, let cmf = commandField?.stringValue{
            do{
                try realm.write({
                    let r = Row()
                    r.computer = cf
                    r.command = cmf
                    realm.add(r)
                })
            }catch{
                print("\(error)")
            }
        }
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "ChangeTableView"), object: nil)
        dismiss(self)
    }
    @IBAction func cancel(_ sender: NSButton) {
        let nc = NotificationCenter.default
        nc.post(name: NSNotification.Name(rawValue: "ChangeTableView"), object: nil)
        dismiss(self)
    }
}
