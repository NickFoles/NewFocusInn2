//
//  GameViewController.swift
//  NewFocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/29/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import FirebaseAuth
import FirebaseDatabase

class GameViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var previousScale:CGFloat = 1.0

    //var previousScale:CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // used to access the sidebar menu
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }

//        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(sender:)))
//        self.view.addGestureRecognizer(gesture)
    }

//    @objc func pinchAction(sender:UIPinchGestureRecognizer) {
//        let scale:CGFloat = previousScale * sender.scale
//        self.view.transform = CGAffineTransform(scaleX: scale, y: scale);
//        previousScale = sender.scale
//    }
//
    @IBAction func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer) {   guard gestureRecognizer.view != nil else { return }
        let minScale: CGFloat = 1.0
        let maxScale: CGFloat = 4.0
        
        
        let currentScale = view.frame.width/view.bounds.size.width
        var newScale = gestureRecognizer.scale
        
        if currentScale * gestureRecognizer.scale < minScale {
            newScale = minScale / currentScale
        }
        else if currentScale * gestureRecognizer.scale > maxScale {
            newScale = maxScale / currentScale
        }
        view.transform = view.transform.scaledBy(x: newScale, y: newScale)
        
//        print("current scale: \(currentScale), new scale: \(newScale)")
        
        gestureRecognizer.scale = 1
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
