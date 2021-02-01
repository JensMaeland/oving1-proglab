//
//  MainMenu.swift
//  oving1-pong
//
//  Created by Jonas Sæther on 01/02/2021.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {

    var buttonPong = SKLabelNode()
    var buttonHeli = SKLabelNode()

    override func didMove(to view: SKView) {
        /* Setup your scene here */

        /* Set UI connections */
        buttonPong = self.childNode(withName: "buttonPong") as! SKLabelNode;
        buttonHeli = self.childNode(withName: "buttonHeli") as! SKLabelNode;
        
    }
    
    func loadGame(game: String) {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        /* 2) Load Game scene */
        guard let scene = GameScene(fileNamed:game) else {
            print("Could not make GameScene, check the name is spelled correctly")
            return
        }

        /* 3) Ensure correct aspect mode */
        scene.scaleMode = .aspectFill

        /* Show debug */
        skView.showsPhysics = true
        skView.showsDrawCount = true
        skView.showsFPS = true

        /* 4) Start game scene */
        skView.presentScene(scene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            if (node.name == "buttonPong") {
                self.loadGame(game: "GameScene");
            }
            else if (node.name == "buttonHeli") {
                self.loadGame(game: "HeliScene");
            }
        }
    }
}
