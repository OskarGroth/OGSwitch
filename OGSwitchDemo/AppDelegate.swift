//
//  AppDelegate.swift
//  OGSwitchDemo
//
//  Created by Oskar Groth on 2017-02-22.
//  Copyright © 2017 Oskar Groth. All rights reserved.
//

import Cocoa
import OGSwitch

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var switchButton: OGSwitch!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func switchPress(_ sender: Any) {
        NSLog("Switch is now: \((sender as! OGSwitch).isOn)")
       // perform(#selector(timer), with: nil, afterDelay: 3)
    }
    
    @objc func timer() {
        NSLog("Switch is after timer trigger now: \(switchButton.isOn)")
       // switchButton.setOn(isOn: !switchButton.isOn, animated: false)
    }

}

