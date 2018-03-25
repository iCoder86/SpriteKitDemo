//
//  GameScene.swift
//  MoveObjects
//
//  Created by cloudZon Infosoft on 23/03/18.
//  Copyright © 2018 Me. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private let kAnimalNodeName = "movable"
    
    let background = SKSpriteNode(imageNamed: "blue-shooting-stars")
    var selectedNode = SKSpriteNode()
    
    var character: Character
    
    override init(size:CGSize) {
        character = Character()
        
        super.init(size:size)
        
        setup()
        
        character = Character.init(self, atPosition: CGPoint(x: 100, y: 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setUpPhysicWorld()
        setUpEnvironment()
//        addObjects()
        createCharacter()
    }

    func createCharacter () {
        
    }

    func setUpPhysicWorld () {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.8)
        physicsWorld.speed = 1.0
        
        // Creates Physics Boundry
        physicsBody = SKPhysicsBody.init(edgeLoopFrom: frame)
    }
    
    func setUpEnvironment() {
        self.background.name = "blue-shooting-stars"
        self.background.anchorPoint = CGPoint(x: 0, y: 0)
        self.background.zPosition = -1;
        self.addChild(background)
    }
    
    func addObjects() {
        let imageNames = ["bird", "cat", "dog", "turtle"]
        
        for i in 0..<imageNames.count {
            
            let offsetFraction = (CGFloat(i) + 1.0)/(CGFloat(imageNames.count) + 1.0)
            let animal = Animal(name: imageNames[i], position: CGPoint(x: size.width * offsetFraction, y: size.height / 2))
            animal.addToScene(self)
        }
    }
    
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * M_PI)
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        
        let touchedNode = self.atPoint(touchLocation)
        if touchedNode is SKSpriteNode {
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as! SKSpriteNode
                
                if touchedNode.name! == kAnimalNodeName {
                    let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                                                      SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                                      SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
                    selectedNode.run(SKAction.repeatForever(sequence))
                }
            }
        }
    }
    
    func boundLayerPos(aNewPosition: CGPoint) -> CGPoint {
        let winSize = self.size
        var retval = aNewPosition
        retval.x = CGFloat(min(retval.x, 0))
        retval.x = CGFloat(max(retval.x, -(background.size.width) + winSize.width))
        retval.y = self.position.y
        
        return retval
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode.position
        
        if selectedNode.name! == kAnimalNodeName {
            selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        } else {
            let aNewPosition = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
            background.position = self.boundLayerPos(aNewPosition: aNewPosition)
        }
    }

    
    func touchDown(atPoint pos : CGPoint) {
        selectNodeForTouch(touchLocation: pos)
        character.animateCharacter(character)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
        for touch in touches {
            let positionInScene = touch.location(in:self)
            let previousPosition = touch.previousLocation(in: self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
            panForTranslation(translation: translation)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
