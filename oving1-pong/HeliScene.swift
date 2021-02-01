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
    var exit = SKLabelNode()
    var label = SKLabelNode()
    var texture = SKTexture()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        exit = self.childNode(withName: "exit") as! SKLabelNode
        label = self.childNode(withName: "label") as! SKLabelNode
        
        choppa = self.childNode(withName: "choppa") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        //texture = self.texture(withName: "helitexture") as! SKTexture
        
        choppa.physicsBody?.mass = 0
        choppa.physicsBody?.restitution = 1
        choppa.physicsBody?.friction = 0
        choppa.physicsBody?.linearDamping = 0.05
        choppa.physicsBody?.angularDamping = 0
        choppa.physicsBody?.applyImpulse(CGVector(dx: 375, dy: 275))
        
        let animation = SKAction.animate(with: choppa.texture, timePerFrame: 0.1)

        choppa.run(animation)
         
        
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
        guard let scene = GameScene(fileNamed: "MainMenu") else {
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
            let location = touch.location(in: self)
            choppa.physicsBody?.applyImpulse(CGVector(dx: location.x, dy: location.y))
            let node = self.atPoint(touch.location(in: self))
            if (node.name == "exit") {
                self.mainMenu();
            }
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            choppa.physicsBody?.applyImpulse(CGVector(dx: location.x/10, dy: location.y/10))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if choppa.position.x <= -190 {
            choppa.run(SKAction.scaleX(to: -1, duration: 0.2))
        }
        if choppa.position.x <= -220 {
            
            choppa.physicsBody?.applyImpulse(CGVector(dx: -20, dy: 20))
        }
        if choppa.position.x >= 220 {
            
            choppa.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        if choppa.position.x >= 190 {
            choppa.run(SKAction.scaleX(to: 1, duration: 0.2))
        }
        label.text = "x\(Int(choppa.position.x)),y\(Int(choppa.position.y))";
    }
}
