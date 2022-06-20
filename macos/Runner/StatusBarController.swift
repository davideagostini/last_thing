//
//  StatusBarController.swift
//  Runner
//
//  Created by Davide Agostini on 18/06/22.
//

import Foundation
import AppKit

class StatusBarController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var popover: NSPopover
    
    init(_ popover: NSPopover) {
        self.popover = popover
        statusBar = NSStatusBar.init()
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
        changeStatusBarButton(thing: "Loading...")
        
    }
    
    @objc func togglePopover(sender: AnyObject) {
        if(popover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject) {
        if let statusBarButton = statusItem.button {
            popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: NSRectEdge.maxY)
        }
    }
    
    func hidePopover(_ sender: AnyObject) {
        popover.performClose(sender)
    }
    
    func changeStatusBarButton(thing: String?, hex: String? = "#FFFFFFFF") {
        if let statusBarButton = statusItem.button {
            //statusBarButton.title = thing ?? "Last thing"
            
            let myAttribute = [ NSAttributedString.Key.foregroundColor: NSColor(hex: hex!), NSAttributedString.Key.font: NSFont.boldSystemFont(ofSize: NSFont.systemFontSize) ]
            let myAttrString = NSAttributedString(string: thing ?? "Last thing", attributes: myAttribute as [NSAttributedString.Key : Any])
            statusBarButton.attributedTitle = myAttrString
            
            //statusBarButton.image = #imageLiteral(resourceName: "AppIcon") //change this to your desired image
            //statusBarButton.image?.size = NSSize(width: 18.0, height: 18.0)
            //statusBarButton.image?.isTemplate = true
            statusBarButton.action = #selector(togglePopover(sender:))
            statusBarButton.target = self
        }
    }
}
