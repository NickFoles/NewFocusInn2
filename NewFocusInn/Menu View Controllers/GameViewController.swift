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

var houseList = [""]

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
    @IBAction func pinchGesture(_ gestureRecognizer : UIPinchGestureRecognizer) {   guard gestureRecognizer.view != nil else { return }
        let minScale: CGFloat = 1.0
        let maxScale: CGFloat = 4.0
        
        let pinchCenter = CGPoint(x: gestureRecognizer.location(in: view).x - view.bounds.midX,
                                  y: gestureRecognizer.location(in: view).y - view.bounds.midY)
        
        let currentScale = view.frame.width/view.bounds.size.width
        var newScale = gestureRecognizer.scale
        
        if currentScale * newScale < minScale {
            newScale = minScale / currentScale
            view.transform = .identity
        }
            
        else if currentScale * newScale > maxScale {
            newScale = maxScale / currentScale
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: newScale, y: newScale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            
            view.transform = transform
        }
            
        else {
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: newScale, y: newScale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            
            view.transform = transform
        }
        gestureRecognizer.scale = 1
    }
    
    var initialCenter = CGPoint()  // The initial center point of the view.
    @IBAction func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
//        guard gestureRecognizer.view != nil else {return}
//        let piece = gestureRecognizer.view!
//        let initialPoint = gestureRecognizer.location(in: view)
//        let currentScale = view.frame.width/view.bounds.size.width
//        // Get the changes in the X and Y directions relative to
//        // the superview's coordinate space.
//        let translation = gestureRecognizer.translation(in: piece.superview)
//        if gestureRecognizer.state == .began {
//            // Save the view's original position. 
//            self.initialCenter = piece.center
//        }
//        // Update the position for the .began, .changed, and .ended states
//        if gestureRecognizer.state != .cancelled {
//            // Add the X and Y translation to the view's original position.
//            var newCenter = CGPoint()
//            
//            if view.frame.minX > 0 || view.frame.maxX < view.bounds.width{
//                newCenter.x = initialCenter.x
//                newCenter.y = initialCenter.y + translation.y
//            }
//            else {
//                newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
//            }
//            piece.center = newCenter
//        }
//        print(initialPoint.x)
//        print(translation.x / currentScale)
//        print("space")
//        print(view.frame.maxX)
//        print(view.frame.minX)
//        print(view.frame.maxY)
//        print(view.frame.minY)
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
