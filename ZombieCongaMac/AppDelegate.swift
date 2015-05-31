//
//  AppDelegate.swift
//  ZombieCongaMac
//
//  Created by altair21 on 15/6/1.
//  Copyright (c) 2015年 altair21. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow?
    @IBOutlet var skView: SKView?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        let scene = MainMenuScene(size: CGSize(width: 2048, height: 1536))
        scene.scaleMode = .AspectFill
        self.skView!.presentScene(scene)
        self.skView!.ignoresSiblingOrder = true
        self.skView!.showsFPS = true
        self.skView!.showsNodeCount = true
    }
    
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
