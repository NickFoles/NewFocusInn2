//
//  GameScene.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var grass: SKTileMapNode?
    let house = SKSpriteNode(imageNamed: "house")
    let eiffel = SKSpriteNode(imageNamed: "eiffel")
    let coor = [[0,2], [-0.5,2.5],[0.5,2.5], [-1,3],[0,3],[1,3], [-1.5,3.5],[-0.5,3.5],[0.5,3.5],[1.5,3.5], [-2,4],[-1,4],[0,4],[1,4],[2,4], [-1.5,4.5],[-0.5,4.5],[0.5,4.5],[1.5,4.5], [-1,5],[0,5],[1,5], [-0.5,5.5],[0.5,5.5], [0,6]]
    
    override func didMove(to view: SKView) {
        self.grass = self.childNode(withName: "//Grass Map Node") as? SKTileMapNode
        house(x: coor[3][0], y: coor[3][1], building: house)
        eiffel(x: coor[13][0], y: coor[13][1], building: eiffel)
    }
    
    func house (x: Double, y: Double, building: SKSpriteNode) {
        if let grass = self.grass {
            building.position = CGPoint(x: grass.tileSize.width * CGFloat(x), y: grass.tileSize.height * CGFloat(y) + 7)
            addChild(building)
        }
    }
    func eiffel (x: Double, y: Double, building: SKSpriteNode) {
        if let grass = self.grass {
            building.position = CGPoint(x: grass.tileSize.width * CGFloat(x), y: grass.tileSize.height * CGFloat(y) + 32)
            addChild(building)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
