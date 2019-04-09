//
//  WinnerViewController.swift
//  TVOSBasics
//
//  Created by Cibele Paulino on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class WinnerViewController: UIViewController {

    var sceneView = SCNView.init()
    var scene = WinnerScene.init()
    var victoryView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = UIView()
        
        sceneView.scene = scene
        self.sceneView.backgroundColor = UIColor.flLightBlue
        
        setupSceneView()
        setupInput()
        
        view.addSubview(self.victoryView)
        configVictoryView()
        
    }

    func setupSceneView() {
        self.view.addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            sceneView.constraints(toFill: view)
        )
        
        sceneView.backgroundColor = UIColor.black
        sceneView.isUserInteractionEnabled = true
    }
    
    func setupInput() {
        let swipeRecognizer = ForceSwipeGestureRecognizer.init(
            target: self,
            action: #selector(swipeHappend(recognizer:)),
            forceFactor: 2.0
        )
        
        sceneView.addGestureRecognizer(swipeRecognizer)
    }
    
    @objc func swipeHappend(recognizer: ForceSwipeGestureRecognizer) {
        if recognizer.state == .ended {
            let panForce = recognizer.force(in: sceneView)
            
        }
    }
    
    func configVictoryView() {
        self.victoryView.translatesAutoresizingMaskIntoConstraints = false
        self.victoryView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        self.victoryView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        self.victoryView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        self.victoryView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.75).isActive = true
        
        let victoryImage = UIImage.init(named: "victoryScene")
        let victoryImageView = UIImageView.init(image: victoryImage)
        victoryImageView.contentMode = .scaleAspectFit
        self.victoryView.addSubview(victoryImageView)
        
        victoryImageView.translatesAutoresizingMaskIntoConstraints = false
        victoryImageView.centerYAnchor.constraint(equalTo: self.victoryView.centerYAnchor, constant: 0).isActive = true
        victoryImageView.centerXAnchor.constraint(equalTo: self.victoryView.centerXAnchor, constant: 0).isActive = true
        victoryImageView.widthAnchor.constraint(equalToConstant: 900.0).isActive = true
        victoryImageView.heightAnchor.constraint(equalToConstant: 900.0).isActive = true
        
        let bannerImage = UIImage.init(named: "Rectangle")
        let bannerView = UIImageView.init(image: bannerImage)
        bannerView.contentMode = .scaleAspectFit
        self.victoryView.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.centerYAnchor.constraint(equalTo: self.victoryView.centerYAnchor, constant: 200).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: self.victoryView.centerXAnchor, constant: 0).isActive = true
        bannerView.widthAnchor.constraint(equalToConstant: 900.0).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        let labelBanner = UILabel()
        labelBanner.text = "Thunder"
        labelBanner.textAlignment = .center
        labelBanner.font = labelBanner.font.withSize(70)
        
        labelBanner.textColor = UIColor.init(named: "flRed")
        bannerView.addSubview(labelBanner)
        labelBanner.translatesAutoresizingMaskIntoConstraints = false
        labelBanner.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor, constant: -30).isActive = true
        labelBanner.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor, constant: 0).isActive = true
        
    }
}
