//
//  ViewController.swift
//  TerminalCommandsAutomator
//
//  Created by Jaival Bhuptani on 2020-11-19.
//

import Cocoa
import RealmSwift
import ShellOut

class ViewController: NSViewController{

    // Realm object
    let realm = try! Realm()
    var rows:Results<Row>?
    var latestR : Int?
    var latestC : Int?
    @IBOutlet weak var segmentedControl: NSSegmentedCell!
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        load()
        tableView.target = self
        // Double click listener
        tableView.action = #selector(onItemClicked)
    }
    @objc private func onItemClicked() {
        latestR = tableView.clickedRow
        latestC = tableView.clickedColumn
    }
    override func viewWillAppear() {
        load()
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    // Segment controller
    @IBAction func addOrRemove(_ sender: NSSegmentedCell) {
        switch self.segmentedControl.selectedSegment{
        case 0:
            add()
            break
                
        case 1:
            delete()
            break
                
        default:
                break
            }
    }
    // Add row
    func add(){
        do{
            let r = Row()
            r.computer = ""
            r.command = ""
            r.password = ""
            try realm.write({
                realm.add(r)
            })
        }catch{
            print("\(error)")
        }
        tableView.reloadData()
    }
    //Delete row
    func delete(){
        if tableView.selectedRow != -1{
            if let r = rows?[tableView.selectedRow]{
                do{
                    try self.realm.write {
                        realm.delete(r)
                    }
                }catch{
                    print("\(error)")
                }
            }
        }
        tableView.reloadData()
    }
    
    // Load Rows
    func load(){
        rows = realm.objects(Row.self)
        tableView.reloadData()
    }

    

}
//MARK:- TableView Methods
extension ViewController: NSTableViewDataSource, NSTableViewDelegate{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return rows?.count ?? 0
        }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let r = rows?[row]{
         
            if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "Computer") {
         
                let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "computerCell")
                guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? TextFieldCell else { return nil }
                cellView.tf.delegate = self
                if r.computer == ""{
                    cellView.tf.drawsBackground = true
                }
                else{
                    cellView.tf.drawsBackground = false
                }
                cellView.tf.stringValue = r.computer
                return cellView
         
            } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "Command") {
         
                let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "commandCell")
                guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? TextFieldCell else { return nil }
                cellView.tf.delegate = self
                if r.command == ""{
                    cellView.tf.drawsBackground = true
                }
                else{
                    cellView.tf.drawsBackground = false
                }
                cellView.tf.stringValue = r.command
                return cellView
         
         
            } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "Connect") {
                let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "connectCell")
                guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NewTableCell else { return nil }
                cellView.delegate = self
                cellView.index = row
                return cellView
            }else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "Password") {
                
                let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "passwordCell")
                guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? TextFieldCell else { return nil }
                cellView.tf.delegate = self
                if r.password == ""{
                    cellView.tf.drawsBackground = true
                }
                else{
                    cellView.tf.drawsBackground = false
                }
                cellView.tf.stringValue = r.password
                return cellView
         
         
            }
        }
            return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
            return 20
        }
    
}

//MARK:- Custom cell to listen to button clicks
extension ViewController: cellRowNum{
    func  convertIntoStr(subStr s : ArraySlice<String.SubSequence>) -> [String] {
        var ns:[String] = []
        for i in s{
            ns.append(String(i))
        }
        return ns
    }
    func onClick(index: Int) {
        if let r = rows?[index]{
            if r.command != "" && r.password != "" && r.command != ""{
                do{
                    try shellOut(to: [r.command, r.password])
                }catch{
                    print(error)
                }
            }
        }
    }
}

extension ViewController:NSTextFieldDelegate{
    func control(_ control: NSControl, textShouldEndEditing fieldEditor: NSText) -> Bool {
        if let r = latestR, let c = latestC{
            if let row = rows?[r]{
                if c == 0{
                    do{

                        try realm.write({
                            row.computer = fieldEditor.string
                            })
                    }catch{
                        print("\(error)")
                    }
                }
                else if c == 1{
                    do{

                        try realm.write({
                            row.command = fieldEditor.string
                            })
                    }catch{
                        print("\(error)")
                    }
                }
                else if c == 2{
                    do{

                        try realm.write({
                            row.password = fieldEditor.string
                            })
                    }catch{
                        print("\(error)")
                    }
                }
            }
        }
        tableView.reloadData()
        return true
    }
}
