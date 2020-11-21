//
//  Row.swift
//  TerminalCommandsAutomator
//
//  Created by Jaival Bhuptani on 2020-11-19.
//

import Foundation
import RealmSwift

class Row:Object{
    @objc dynamic var computer:String = ""
    @objc dynamic var command:String = ""
    @objc dynamic var password:String = ""
}
