//
//  PaperPlateViewController.swift
//  TVOSBasics
//
//  Created by Paloma Bispo on 08/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class PaperPlateViewController: UIViewController {
    
    var scnView: SCNView!
    var scnScene: PaperPlateScene!
    var cameraNode: SCNNode!
    var tube: SCNTube!
    var table: SCNPlane!
    var pan: DistancePanGestureRecognizer!
    let force = SCNVector3(0, 0, -50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupGestures()
        self.scnScene.addNewBall()
        self.scnScene.newPlates()
    }
    
    private func setupView(){
        self.scnView = SCNView()
        self.scnView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.scnView)
        NSLayoutConstraint.activate(
            self.scnView.constraints(toFill: self.view)
        )
        self.scnView.allowsCameraControl = false
        self.scnView.showsStatistics = true
        self.scnView.debugOptions = .showPhysicsShapes
    }
    
    private func setupScene() {
        self.scnScene = PaperPlateScene()
        self.scnView.scene = self.scnScene
        self.scnScene.background.contents = UIImage(named: "background")
    }
    
    private func setupGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        tapGesture.allowedPressTypes = [NSNumber(value: UIPress.PressType.select.rawValue)]
        
        self.pan = DistancePanGestureRecognizer.init(target: self, action: #selector(handlePan))

        
        self.view.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(pan)
    }
    
    @objc func handleTap() {
        self.scnScene.throwBall(withForce: force)
    }
    
    @objc func handlePan() {
        let distance = pan.getDistance(in: self.view)
        self.scnScene.moveStraw(to: distance)
        
    }
}
