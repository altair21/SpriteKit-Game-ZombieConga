//
//  MainMenuScene.swift
//  ZombieConga
//
//  Created by altair21 on 15/5/31.
//  Copyright (c) 2015年 altair21. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "MainMenu")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
    }
    
    #if os(iOS)
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        sceneTapped()
    }
    #else
    override func mouseDown(theEvent: NSEvent) {
        sceneTapped()
    }
    #endif
    
    func sceneTapped() {
        let scene = GameScene(size: self.size)
        scene.scaleMode = self.scaleMode
        let reveal = SKTransition.doorwayWithDuration(1.5)
        self.view?.presentScene(scene, transition: reveal)
    }
    
}