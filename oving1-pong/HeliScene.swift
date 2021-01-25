//
//  HeliScene.swift
//  oving1-pong
//
//  Created by Jonas Sæther on 25/01/2021.
//


import SpriteKit
import GameplayKit

class HeliScene: SKScene {
    
    var choppa = SKSpriteNode()
    var main = SKSpriteNode()
    var topLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        
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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            choppa.position = CGPoint(x: 0, y: 0)
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
