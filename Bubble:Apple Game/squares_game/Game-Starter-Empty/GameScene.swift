//
//  GameScene.swift
//  Game-Starter-Empty
//
//  Created by mitchell hudson on 9/13/18.
//  Copyright © 2018 Make School. All rights reserved.

import SpriteKit
import GameplayKit
import Darwin

class GameScene: SKScene {
    var score = 0
    let scoreLabel = SKLabelNode(fontNamed: "Helvetica")
    var lastUpdateTime: TimeInterval?
    
    // This function is called when the scene is displayed
    override func didMove(to view: SKView) {
        //positioning the score counter
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 25, y: 615)
        addChild(scoreLabel)
        // declare action of running the makeSquare function
        let letsgo  = SKAction.run {
            self.makeSquare()
        }
        let wait = SKAction.wait(forDuration: 1.5)
        let order = SKAction.sequence([letsgo, wait])
        let eternity = SKAction.repeatForever(order)
        self.run(eternity)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let node = atPoint(touchLocation)
            if node.name == "singlesquare" {
                node.removeFromParent()
                score += 1
            }
        }
    }
    
    func movement(to view: SKView) {
    }
    
    // make square
    func makeSquare(){
        guard let view = self.view else{return}
//        let texture = SKTexture(image: UIImage(named: "apple")!)
        
        // declare the attributes for the square
        let randomX = CGFloat(Int.random(in: 50 ... Int(view.bounds.width - 50))) //padding-thx Wes
        let randomSpeed = Double(Int.random(in: 1 ... 4))
//        let size = CGSize(width: 50, height: 50)
        
        let apple = Apple()
        
//        let square = SKSpriteNode(texture: texture, color: .green, size: size)
//        square.name = "singlesquare"
        
        // declare the actions for the square
        let moveUP = SKAction.moveTo(y: view.bounds.height, duration: randomSpeed)
        let remove = SKAction.removeFromParent()
        let hitsTOP = SKAction.run {
            self.score -= 1
        }
        // shove those two into the same variable
        let seq = SKAction.sequence([moveUP, remove, hitsTOP])
        
        apple.position.x = randomX
        addChild(apple)
        
        // make the square run the sequence
        apple.run(seq)
    }
    
//    func gameOver(n: Int) {
//        var start = 0
//        var end = n
//        for i in 0 ... n {
//            if i % 2 == 0 {
//                print(start)
//                start += 1
//            } else {
//                print(end)
//                end -= 1
//            }
//        }
//    }
    
    override func update(_ currentTime: TimeInterval) {
//         Called before each frame is rendered
        var timePassed = TimeInterval()
        if let last = lastUpdateTime {
            timePassed = currentTime - last
        } else {
            timePassed = currentTime
        }
        if timePassed > 0.1 {
            //some time has passed. time to update lastUpdateTime
            lastUpdateTime = currentTime
            //code to show the NEW COUNTER - unless maybe this code belongs 100% in other funcs?
            scoreLabel.text = "Score: \(score)"
        }
    }
}
