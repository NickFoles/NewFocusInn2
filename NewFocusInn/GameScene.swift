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
    let building = SKSpriteNode(imageNamed: "building")
    let eiffel = SKSpriteNode(imageNamed: "eiffel")
    let coor = [[0,2], [-0.5,2.5],[0.5,2.5], [-1,3],[0,3],[1,3], [-1.5,3.5],[-0.5,3.5],[0.5,3.5],[1.5,3.5], [-2,4],[-1,4],[0,4],[1,4],[2,4], [-1.5,4.5],[-0.5,4.5],[0.5,4.5],[1.5,4.5], [-1,5],[0,5],[1,5], [-0.5,5.5],[0.5,5.5], [0,6]]
    
    override func didMove(to view: SKView) {
        self.grass = self.childNode(withName: "//Grass Map Node") as? SKTileMapNode
        placeBuilding(x: coor[3][0], y: coor[3][1], build: house)
        placeBuilding(x: coor[14][0], y: coor[14][1], build: eiffel)
        placeBuilding(x: coor[15][0], y: coor[15][1], build: building)
    }
    
    func placeBuilding (x: Double, y: Double, build: SKSpriteNode) {
        if let grass = self.grass {
            if build == house {
                build.position = CGPoint(x: grass.tileSize.width * CGFloat(x), y: grass.tileSize.height * CGFloat(y) + 7)
                addChild(build)
            }
            else if build == building {
                build.position = CGPoint(x: grass.tileSize.width * CGFloat(x), y: grass.tileSize.height * CGFloat(y) + 30)
                addChild(build)
            }
            else if build == eiffel {
                build.position = CGPoint(x: grass.tileSize.width * CGFloat(x), y: grass.tileSize.height * CGFloat(y) + 32)
                addChild(build)
            }
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
