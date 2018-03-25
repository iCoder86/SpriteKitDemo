//
//  Animal.swift
//  MoveObjects
//
//  Created by cloudZon Infosoft on 23/03/18.
//  Copyright © 2018 Me. All rights reserved.
//

import UIKit
import SpriteKit

class Animal: SKNode {
    private let kAnimalNodeName = "movable"
    private var animalPosition: CGPoint
    private var animalName: String
    
    init(name:String, position: CGPoint) {
        self.animalPosition = position
        self.animalName = name
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        animalPosition = aDecoder.decodeCGPoint(forKey: "animalPosition")
        animalName = aDecoder.decodeObject(forKey: "animalName") as! String
        super.init(coder: aDecoder)
    }
    
    func addToScene(_ scene: SKScene) {
        
        zPosition = 1;
        
        let animal = SKSpriteNode(imageNamed: animalName)
        animal.position = animalPosition
        animal.name = kAnimalNodeName
        addChild(animal)
        
        animal.physicsBody = SKPhysicsBody(texture: animal.texture!, size: (animal.texture?.size())!)
        animal.physicsBody?.categoryBitMask = 1
        animal.physicsBody?.collisionBitMask = 1
        animal.physicsBody?.isDynamic = true
        
        scene.addChild(self)
        
        // Connect Animals With Static Node
        let staticNode = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        staticNode.name = kAnimalNodeName
        staticNode.position = CGPoint(x: animalPosition.x, y: animalPosition.y+200)
        staticNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        staticNode.physicsBody?.isDynamic = false
        scene.addChild(staticNode)

        
//        let joints = SKPhysicsJointSpring.joint(withBodyA: staticNode.physicsBody!,
//                                                bodyB: animal.physicsBody!,
//                                                anchorA: staticNode.position,
//                                                anchorB: CGPoint(x: animalPosition.x, y: animalPosition.y+25))
//        joints.frequency = 1.5
//        joints.damping = 0.5

//        let joints = SKPhysicsJointPin.joint(withBodyA: staticNode.physicsBody!,
//                                          bodyB: animal.physicsBody!,
//                                          anchor: CGPoint(x: animalPosition.x, y: animalPosition.y+25))
        
//        let joints = SKPhysicsJointSliding.joint(withBodyA: staticNode.physicsBody!,
//                                                 bodyB: animal.physicsBody!,
//                                                 anchor: CGPoint(x: animalPosition.x, y: animalPosition.y+25),
//                                                 axis: CGVector(dx: -30, dy: 0))

//        let joints = SKPhysicsJointLimit.joint(withBodyA: staticNode.physicsBody!,
//                                               bodyB: animal.physicsBody!,
//                                               anchorA: staticNode.position,
//                                               anchorB: CGPoint(x: 100, y: 200))
        
//        scene.physicsWorld.add(joints)
    }
}
