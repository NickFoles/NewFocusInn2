//
//  GameScene.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import SpriteKit
import GameplayKit

// coordinates of tiles from top tile and down the column
let coor = [
    [0,7],[-0.5,6.5],[-1,6],[-1.5,5.5],[-2,5],[-2.5,4.5],[-3,4],[-3.5,3.5],[-4,3],[-4.5,2.5],[-5,2],[-5.5,1.5],[-6,1],[-6.5,0.5],[-7,0],
    [0.5,6.5],[0,6],[-0.5,5.5],[-1,5],[-1.5,4.5],[-2,4],[-2.5,3.5],[-3,3],[-3.5,2.5],[-4,2],[-4.5,1.5],[-5,1],[-5.5,0.5],[-6,0],[-6.5,-0.5],
    [1,6],[0.5,5.5],[0,5],[-0.5,4.5],[-1,4],[-1.5,3.5],[-2,3],[-2.5,2.5],[-3,2],[-3.5,1.5],[-4,1],[-4.5,0.5],[-5,0],[-5.5,-0.5],[-6,-1],
    [1.5,5.5],[1,5],[0.5,4.5],[0,4],[-0.5,3.5],[-1,3],[-1.5,2.5],[-2,2],[-2.5,1.5],[-3,1],[-3.5,0.5],[-4,0],[-4.5,-0.5],[-5,-1],[-5.5,-1.5],
    [2,5],[1.5,4.5],[1,4],[0.5,3.5],[0,3],[-0.5,2.5],[-1,2],[-1.5,1.5],[-2,1],[-2.5,0.5],[-3,0],[-3.5,-0.5],[-4,-1],[-4.5,-1.5],[-5,-2],
    [2.5,4.5],[2,4],[1.5,3.5],[1,3],[0.5,2.5],[0,2],[-0.5,1.5],[-1,1],[-1.5,0.5],[-2,0],[-2.5,-0.5],[-3,-1],[-3.5,-1.5],[-4,-2],[-4.5,-2.5],
    [3,4],[2.5,3.5],[2,3],[1.5,2.5],[1,2],[0.5,1.5],[0,1],[-0.5,0.5],[-1,0],[-1.5,-0.5],[-2,-1],[-2.5,-1.5],[-3,-2],[-3.5,-2.5],[-4,-3],
    [3.5,3.5],[3,3],[2.5,2.5],[2,2],[1.5,1.5],[1,1],[0.5,0.5],[0,0],[-0.5,-0.5],[-1,-1],[-1.5,-1.5],[-2,-2],[-2.5,-2.5],[-3,-3],[-3.5,-3.5],
    [4,3],[3.5,2.5],[3,2],[2.5,1.5],[2,1],[1.5,0.5],[1,0],[0.5,-0.5],[0,-1],[-0.5,-1.5],[-1,-2],[-1.5,-2.5],[-2,-3],[-2.5,-3.5],[-3,-4],
    [4.5,2.5],[4,2],[3.5,1.5],[3,1],[2.5,0.5],[2,0],[1.5,-0.5],[1,-1],[0.5,-1.5],[0,-2],[-0.5,-2.5],[-1,-3],[-1.5,-3.5],[-2,-4],[-2.5,-4.5],
    [5,2],[4.5,1.5],[4,1],[3.5,0.5],[3,0],[2.5,-0.5],[2,-1],[1.5,-1.5],[1,-2],[0.5,-2.5],[0,-3],[-0.5,-3.5],[-1,-4],[-1.5,-4.5],[-2,-5],
    [5.5,1.5],[5,1],[4.5,0.5],[4,0],[3.5,-0.5],[3,-1],[2.5,-1.5],[2,-2],[1.5,-2.5],[1,-3],[0.5,-3.5],[0,-4],[-0.5,-4.5],[-1,-5],[-1.5,-5.5],
    [6,1],[5.5,0.5],[5,0],[4.5,-0.5],[4,-1],[3.5,-1.5],[3,-2],[2.5,-2.5],[2,-3],[1.5,-3.5],[1,-4],[0.5,-4.5],[0,-5],[-0.5,-5.5],[-1,-6],
    [6.5,0.5],[6,0],[5.5,-0.5],[5,-1],[4.5,-1.5],[4,-2],[3.5,-2.5],[3,-3],[2.5,-3.5],[2,-4],[1.5,-4.5],[1,-5],[0.5,-5.5],[0,-6],[-0.5,-6.5],
    [7,0],[6.5,-0.5],[6,-1],[5.5,-1.5],[5,-2],[4.5,-2.5],[4,-3],[3.5,-3.5],[3,-4],[2.5,-4.5],[2,-5],[1.5,-5.5],[1,-6],[0.5,-6.5],[0,-7]
]

class GameScene: SKScene {
    private var grass: SKTileMapNode?
    
    override func didMove(to view: SKView) {
        self.grass = self.childNode(withName: "//Grass Map Node") as? SKTileMapNode
        for i in 0 ..< houseList.count {
            if houseList[i] != "" {
                placeBuilding(x: coor[i][0], y: coor[i][1], build: houseList[i])
            }
        }
    }
    
    func placeBuilding (x: Double, y: Double, build: String) {
        if let grass = self.grass {
            let building = SKSpriteNode(imageNamed: build)
            building.size = CGSize(width: building.size.width * grass.xScale, height: building.size.height * grass.yScale)
            
            if build == "house" || build == "pink house" || build == "newspaper place" || build == "ice cream store" || build == "cinema" || build == "petco" || build == "wawa" {
                building.position = CGPoint(x: grass.tileSize.width * grass.xScale * CGFloat(x), y: grass.tileSize.height * grass.yScale * CGFloat(y) + building.size.height/2 * grass.yScale + 2)
            }
            else if build == "eiffel tower" {
                building.position = CGPoint(x: grass.tileSize.width * grass.xScale * CGFloat(x), y: grass.tileSize.height * grass.yScale * CGFloat(y) + building.size.height/2 * grass.yScale + 9)
            }
            else if build == "tall building" {
                building.position = CGPoint(x: grass.tileSize.width * grass.xScale * CGFloat(x), y: grass.tileSize.height * grass.yScale * CGFloat(y) + building.size.height/2 * grass.yScale + 7)
            }
            else if build == "empire state building" {
                building.position = CGPoint(x: grass.tileSize.width * grass.xScale * CGFloat(x), y: grass.tileSize.height * grass.yScale * CGFloat(y) + building.size.height/2 * grass.yScale + 14)
            }
            else if build == "gray building" {
                building.position = CGPoint(x: grass.tileSize.width * grass.xScale * CGFloat(x), y: grass.tileSize.height * grass.yScale * CGFloat(y) + building.size.height/2 * grass.yScale + 8)
            }
            
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
