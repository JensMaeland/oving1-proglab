//
//  GameScene.swift
//  oving1-pong
//
//  Created by Jens Mæland on 24/01/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var button2 = SKSpriteNode()
    
    var topLabel = SKLabelNode()
    var btmLabel = SKLabelNode()
    var exit = SKLabelNode()
    var playAgain = SKLabelNode()
    
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLabel = self.childNode(withName: "btmLabel") as! SKLabelNode
        exit = self.childNode(withName: "exit") as! SKLabelNode
        playAgain = self.childNode(withName: "playAgain") as! SKLabelNode
        
        button2 = self.childNode(withName: "button2") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        
    }
    
    func startGame() {
        score = [0,0]
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.applyImpulse(CGVector(dx: 18, dy: 18))
        
        playAgain.isHidden = true
        button2.isHidden = true
        topLabel.text = "\(score[1])"
        btmLabel.text = "\(score[0])"
        
    }
    
    func stopGame() {
        
        playAgain.isHidden = false
        button2.isHidden = false
        ball.position = CGPoint(x: 0, y: 0)

    }
    
    func addScore(playerWinner : SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        checkWinner1:if playerWinner == main {
            score[0] += 1
            if score[0] > 2 {
                stopGame()
                break checkWinner1
            }
            ball.physicsBody?.applyImpulse(CGVector(dx: 18, dy: 18))
            
        }
        
        checkWinner2:if playerWinner == enemy{
            score[1] += 1
            if score[1] > 2 {
                stopGame()
                break checkWinner2
            }
            ball.physicsBody?.applyImpulse(CGVector(dx: -18, dy: -18))
        }
        
        topLabel.text = "\(score[1])"
        btmLabel.text = "\(score[0])"
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = self.atPoint(location)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            if (node.name == "exit") {
                self.mainMenu();
            }
            if (node.name == "playAgain") {
                self.startGame()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.5))
        
        if ball.position.y <= main.position.y - 40 {
            addScore(playerWinner: enemy)
        }
        
        else if ball.position.y >= enemy.position.y + 40 {
            addScore(playerWinner: main)
        }
        
    }
}
