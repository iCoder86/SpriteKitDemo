//
//  Character.swift
//  MoveObjects
//
//  Created by Mehul on 24/03/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit
import SpriteKit

class Character: SKSpriteNode {
    
    private let kAnimalNodeName = "movable"
    
    private var head: SKSpriteNode!
    private var leftLeg: SKSpriteNode!
    private var leftHand: SKSpriteNode!
    private var rightLeg: SKSpriteNode!
    private var rightHand: SKSpriteNode!
    private var stomach: SKSpriteNode!
    
    init() {
        super.init(texture: nil, color: UIColor.yellow, size: CGSize(width: 10, height: 10))
    }
    
    init(_ scene:SKScene, atPosition position:CGPoint) {
        super.init(texture: nil, color: UIColor.red, size: CGSize(width: 10, height: 10))
        prepareCharacter(scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func prepareCharacter(_ scene:SKScene) -> (Character) {
        zPosition = 1;
        
        let stomach = SKSpriteNode(imageNamed: "stomach")
        let leftLeg = SKSpriteNode(imageNamed: "leftLeg")
        let leftHand = SKSpriteNode(imageNamed: "leftHand")
        let rightLeg = SKSpriteNode(imageNamed: "rightLeg")
        let rightHand = SKSpriteNode(imageNamed: "rightHand")
        let head = SKSpriteNode(imageNamed: "head")
        
        scene.addChild(self)
        
        head.position = CGPoint(x: 100, y: 162)
        stomach.position = CGPoint(x: 100, y: 100)
        
        leftHand.position = CGPoint(x: 140, y: 90)
        leftLeg.position = CGPoint(x: 93, y: 31)
        
        rightHand.position = CGPoint(x: 70, y: 90)
        rightLeg.position = CGPoint(x: 115, y: 31)
        
        head.name = kAnimalNodeName
        stomach.name = kAnimalNodeName
        leftHand.name = kAnimalNodeName
        leftLeg.name = kAnimalNodeName
        rightHand.name = kAnimalNodeName
        rightLeg.name = kAnimalNodeName
        
        addChild(head)
        addChild(stomach)
        addChild(leftHand)
        addChild(leftLeg)
        addChild(rightHand)
        addChild(rightLeg)
        
        addPhysicsToSpriteNode(head)
        addPhysicsToSpriteNode(stomach)
        addPhysicsToSpriteNode(leftHand)
        addPhysicsToSpriteNode(leftLeg)
        addPhysicsToSpriteNode(rightHand)
        addPhysicsToSpriteNode(rightLeg)

        connectBody(head, stomach)
        connectBody(leftHand, stomach)
        connectBody(leftLeg, stomach)
        connectBody(rightHand, stomach)
        connectBody(rightLeg, stomach)
        
        return self
    }
    
    func addPhysicsToSpriteNode(_ sprite:SKSpriteNode) {
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: (sprite.texture?.size())!)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.collisionBitMask = 1
        sprite.physicsBody?.isDynamic = true
    }
    
    func connectBody(_ body1:SKSpriteNode,_ body2:SKSpriteNode) {
        let midPoint = CGPoint(x: (body1.position.x + body2.position.x)/2, y: (body1.position.y + body2.position.y)/2)
        
        let joints = SKPhysicsJointFixed.joint(withBodyA: body1.physicsBody!,
                                               bodyB: body2.physicsBody!,
                                               anchor:midPoint)
                
        scene?.physicsWorld.add(joints)
    }
    
    public func animateCharacter(_ character:Character) {
        self.leftHand?.position = CGPoint(x: 140, y: 110)
//        character.leftHand.position = CGPoint(x: 140, y: 110)
        
//        let hi = SKAction.reach(to: CGPoint(x: 140, y: 110), rootNode: stomach, duration: 0.1)
//        let restore = SKAction.run {
//            self.leftHand.run(SKAction.rotate(toAngle: 0, duration: 0.1))
//        }
//        leftHand.run(SKAction.sequence([hi, restore]))
    }
    
}
