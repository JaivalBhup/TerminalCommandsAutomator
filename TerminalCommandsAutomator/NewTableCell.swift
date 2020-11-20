//
//  NewTableCell.swift
//  TerminalCommandsAutomator
//
//  Created by Jaival Bhuptani on 2020-11-19.
//

import Cocoa

protocol cellRowNum {
    func onClick(index :Int)
}   

class NewTableCell: NSTableCellView {

    var delegate:cellRowNum?
    var index : Int?
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    @IBAction func buttonClicked(_ sender: NSButton) {
        delegate?.onClick(index: index!)
    }
}
