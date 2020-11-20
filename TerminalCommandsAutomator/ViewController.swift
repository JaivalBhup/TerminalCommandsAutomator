//
//  ViewController.swift
//  TerminalCommandsAutomator
//
//  Created by Jaival Bhuptani on 2020-11-19.
//

import Cocoa
import RealmSwift

class ViewController: NSViewController{

    // Realm object
    let realm = try! Realm()
    var rows:Results<Row>?
    //Notifications
    let nc = NotificationCenter.default
    @IBOutlet weak var segmentedControl: NSSegmentedCell!
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        load()
        // Observer for notifications
        nc.addObserver(self, selector: #selector(changeTableView), name: NSNotification.Name(rawValue: "ChangeTableView"), object: nil)
        tableView.target = self
        // Double click listener
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
        load()
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    // Notification resopnder
    @objc func changeTableView(notification:NSNotification) {
        tableView.reloadData()
    }
    // Double click responder
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        print(tableView.selectedRow)
        performSegue(withIdentifier: "goToEdit", sender: self)
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
        performSegue(withIdentifier: "goToAdd", sender: self)
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
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit"{
            if let destination = segue.destinationController as? EditRow{
                destination.r = rows?[tableView.selectedRow]
            }
        }
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
                guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
                cellView.textField?.stringValue = r.computer
                return cellView
         
            } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "Command") {
         
                let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "commandCell")
                guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else { return nil }
                cellView.textField?.stringValue = r.command
                return cellView
         
         
            } else if tableColumn?.identifier == NSUserInterfaceItemIdentifier(rawValue: "Connect") {
                let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "connectCell")
                guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NewTableCell else { return nil }
                cellView.delegate = self
                cellView.index = row
                return cellView
            }
        }
            return nil
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
            return 23
        }
    
}

//MARK:- Custom cell to listen to button clicks
extension ViewController: cellRowNum{
    func onClick(index: Int) {
        let _ = run("cd")
    }
    @discardableResult func run(_ cmd: String) -> String? {
//        let pipe = Pipe()
//        let process = Process()
//        process.launchPath = "/bin/zsh"
//        process.arguments = ["-c", String(format:"%@", cmd)]
//        process.standardOutput = pipe
//        let fileHandle = pipe.fileHandleForReading
//        process.launch()
//        return String(data: fileHandle.readDataToEndOfFile(), encoding: .utf8)
        
        
//        let task = Process()
//
//        task.launchPath = "/bin/zsh"
//        task.arguments = ["-c", cmd]
//
//        let pipe = Pipe()
//        task.standardOutput = pipe
//        task.standardError = pipe
//        task.launch()
//
//        let data = pipe.fileHandleForReading.readDataToEndOfFile()
//        let output = String(data: data, encoding: .utf8)
//        task.waitUntilExit()
//        return output
        return nil
    }
    
    
}
