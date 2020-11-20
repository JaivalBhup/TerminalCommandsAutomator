//
//  EditRow.swift
//  TerminalCommandsAutomator
//
//  Created by Jaival Bhuptani on 2020-11-20.
//

import Cocoa
import RealmSwift

class EditRow: NSViewController {
    
    var realm = try! Realm()
    
    @IBOutlet weak var computerTF: NSTextField!
    
    @IBOutlet weak var commandTF: NSTextField!
    
    var r : Row?
    override func viewDidLoad() {
        super.viewDidLoad()
        computerTF.stringValue = r?.computer ?? ""
        commandTF.stringValue = r?.command ?? ""
        // Do view setup here.
    }
    @IBAction func edit(_ sender: NSButton) {
        if let cf = computerTF?.stringValue, let cmf = commandTF?.stringValue{
            do{
                try realm.write({
                    r?.command = cmf
                    r?.computer = cf
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
        dismiss(self)
    }
}
