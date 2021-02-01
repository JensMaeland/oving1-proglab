//
//  HeliScene.swift
//  oving1-pong
//
//  Created by Jonas Sæther on 25/01/2021.
//


import SpriteKit
import GameplayKit
import AVFoundation

class HeliScene: SKScene {
    
    var sound: AVAudioPlayer?
    
    var choppa = SKSpriteNode()
    var main = SKSpriteNode()
    var topLabel = SKLabelNode()
    var exit = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        exit = self.childNode(withName: "exit") as! SKLabelNode
        
        choppa = self.childNode(withName: "choppa") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        choppa.physicsBody?.mass = 0
        choppa.physicsBody?.restitution = 1
        choppa.physicsBody?.friction = 0
        choppa.physicsBody?.linearDamping = 0
        choppa.physicsBody?.angularDamping = 0
        choppa.physicsBody?.applyImpulse(CGVector(dx: 175, dy: 275))
         
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        self.playSound();
    }
    
    func mainMenu() {
        /* 1) Grab reference to our SpriteKit view */
        guard let skView = self.view as SKView? else {
            print("Could not get Skview")
            return
        }

        /* 2) Load Game scene */
        guard let scene = GameScene(fileNamed:"MainMenu") else {
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
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "choppa", withExtension: "mov") else { return; }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            sound = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = sound else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            choppa.position = CGPoint(x: 0, y: 0)
            let node = self.atPoint(touch.location(in: self))
            if (node.name == "exit") {
                self.mainMenu();
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            choppa.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if choppa.position.x <= -190 {
            choppa.run(SKAction.scaleX(to: -1, duration: 0.2))
        }
        if choppa.position.x <= -210 {
            
            choppa.physicsBody?.applyImpulse(CGVector(dx: -40, dy: 20))
        }
        if choppa.position.x >= 210 {
            
            choppa.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 20))
        }
        if choppa.position.x >= 190 {
            choppa.run(SKAction.scaleX(to: 1, duration: 0.2))
        }
    }
}
