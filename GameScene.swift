//
//  GameScene.swift
//  playin with gravity
//
//  Created by Anas on 13/10/1440 AH.
//  Copyright © 1440 Anas. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    
    var ball : SKSpriteNode?
    var floor :SKSpriteNode?
    var changer : SKSpriteNode?
    var changer2 : SKSpriteNode?
    var door : SKSpriteNode?
    
    var ballbit : UInt32 = 0x1
    var floorbit : UInt32 = 0x1 << 1
    var changerbit : UInt32 = 0x1 << 2
    var doorbit : UInt32 = 0x1 << 3
    
    
    func addball() {
        ball = self.childNode(withName: "ball") as? SKSpriteNode
        ball?.color = UIColor.blue     
        ball?.colorBlendFactor = 1
        ball?.physicsBody = SKPhysicsBody(circleOfRadius: (ball?.size.width)!/2)
        ball?.physicsBody?.categoryBitMask = ballbit
        ball?.physicsBody?.collisionBitMask = floorbit | doorbit
        ball?.physicsBody?.contactTestBitMask = doorbit | changerbit
        
          
        
    }
    
    func addfloor() {
        floor = self.childNode(withName: "floor") as? SKSpriteNode
        floor?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (floor?.size.width)!, height: (floor?.size.height)!))
        floor?.physicsBody?.categoryBitMask = floorbit
        floor?.physicsBody?.isDynamic = false
        
    }
    
    func adddoor(){
        //for _ in 0...2 {
         door = self.childNode(withName: "doors") as? SKSpriteNode //{
        door?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ((door?.size.width)!), height: ((door?.size.height)!)))
        door?.physicsBody?.categoryBitMask = doorbit
        door?.physicsBody?.collisionBitMask = ballbit
        
            
        door?.physicsBody?.isDynamic = false
        door?.color = UIColor.blue
        
        door?.colorBlendFactor = 1
       
        //}
        //}
    }
    
    func addchanger() {
        
        changer = self.childNode(withName: "changer") as? SKSpriteNode
        changer?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (changer?.size.width)!, height: (changer?.size.height)!))
        changer?.physicsBody?.categoryBitMask = changerbit
        changer?.physicsBody?.isDynamic = false
        
        changer2 = self.childNode(withName: "changer2") as? SKSpriteNode
        changer2?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: (changer2?.size.width)!, height: (changer2?.size.height)!))
        changer2?.physicsBody?.categoryBitMask = changerbit
        changer2?.physicsBody?.isDynamic = false
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        addfloor()
        addball()
        adddoor()
        addchanger()
        
        self.physicsWorld.contactDelegate = self
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var playerbody: SKPhysicsBody?
        var otherbody: SKPhysicsBody?
        
        //checking which body is which
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            
            playerbody = contact.bodyA
            otherbody = contact.bodyB
        }else{
            playerbody = contact.bodyB
            otherbody = contact.bodyA
        }
        
        let plyer = playerbody?.categoryBitMask
        let othr = otherbody?.categoryBitMask
        print("m")
        
        if plyer == ballbit && othr == doorbit {
            print("llll")
            door?.run(SKAction.sequence([SKAction.rotate(byAngle: .pi/4, duration: 0.5),SKAction.wait(forDuration: 6)]) )
            
            door?.run(SKAction.rotate(byAngle: .pi/4, duration: 0.5))
        }
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
   
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
