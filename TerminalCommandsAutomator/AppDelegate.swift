//
//  AppDelegate.swift
//  TerminalCommandsAutomator
//
//  Created by Jaival Bhuptani on 2020-11-19.
//

import Cocoa
import RealmSwift
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowController:NSWindowController?
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your_on
        // For migration remove initial window from the window controller and uncomment the below block....
//        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//        Realm.Configuration.defaultConfiguration = config
//
//        let _ = try! Realm()
//        let storyBoard:NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
//        self.windowController = storyBoard.instantiateController(identifier: "windowController")
//        self.windowController?.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

