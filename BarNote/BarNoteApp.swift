//
//  BarNoteApp.swift
//  BarNote
//
//  Created by Pradyun Setti on 25/01/21.
//

import SwiftUI
import CoreData
import Foundation

@main
struct BarNoteApp: App {
    let persistenceController = PersistenceController.shared
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    let persistenceController = PersistenceController.shared
    var popover = NSPopover.init()
    var statusBarItem: NSStatusItem?

    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let contentView = ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)


        // Set the SwiftUI's ContentView to the Popover's ContentViewController
//        popover.behavior = .transient !!! - This does not seem to work in SwiftUI2.0 or macOS BigSur yet
        popover.animates = true
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        popover.contentSize = NSSize(width: 550, height: 350)
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.title = "BN"
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
    }
    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
//            !!! - displays the popover window with an offset in x in macOS BigSur.
        }
    }
    @objc func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}
