//
//  BallFlowController.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 04/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

public class GameViewController: UIViewController {
    
    let ballPanForceFactor: CGFloat = 5000
    
    var gameState = GameState.inital
    
    lazy var sceneView = SCNView.init()
    lazy var scene = BallFlowScene.init()
    
    public init() {

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = UIView()
        
        sceneView.scene = scene
        
        setupSceneView()
        setupInput()
        
        self.sceneView.backgroundColor = UIColor.clear
    }
    
    @objc func swipeHappend(recognizer: ForceSwipeGestureRecognizer) {
        if recognizer.state == .ended {
            let panForce = recognizer.force(in: sceneView)
        
            scene.moveBall(withForce: panForce)
            
            if gameState == .inital {
                gameState = .playing
                scene.rotateTable()
            }
        }
    }
    
    func setupInput() {
        let swipeRecognizer = ForceSwipeGestureRecognizer.init(
            target: self,
            action: #selector(swipeHappend(recognizer:)),
            forceFactor: ballPanForceFactor
        )
        
        sceneView.addGestureRecognizer(swipeRecognizer)
    }
    
    func setupSceneView() {
        self.view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        sceneView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sceneView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        sceneView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        sceneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        sceneView.backgroundColor = UIColor.black
        sceneView.showsStatistics = true
        sceneView.debugOptions = .showPhysicsShapes
        sceneView.isUserInteractionEnabled = true
    }
}
