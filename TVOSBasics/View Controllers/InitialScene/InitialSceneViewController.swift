//
//  InitialSceneViewController.swift
//  TVOSBasics
//
//  Created by Cibele Paulino on 09/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class InitialSceneViewController: UIViewController {
    
    var scoreBoardView = ScoreBoardView.init()
    var downBox = UIView()
    var gamesBox = UIView()
    var sceneView = SCNView.init()
    var scene = initialScene.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = UIView()
        
        sceneView.scene = scene
        self.sceneView.backgroundColor = UIColor.flLightBlue
        
        setupSceneView()
        setupInput()
        
        view.addSubview(scoreBoardView)
        view.addSubview(downBox)
        
        downViewConfiguration()
        
        self.scoreBoardView.titleLabel.text = "Gincana"
        self.scoreBoardView.roundLabel.text = "Choose your games and enjoy!"
        self.scoreBoardView.redTeamPlaceView.showTurnLabel = false
        
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
            
//            scene.moveBall(withForce: panForce)
        }
    }
    
    func downViewConfiguration() {
        // Set constraints of downBox
        self.downBox.translatesAutoresizingMaskIntoConstraints = false
        self.downBox.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.downBox.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.downBox.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.downBox.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/7).isActive = true
        
        // Create config button
        let confImage = UIImage.init(named: "config")
        let configView = UIImageView.init(image: confImage)
        configView.contentMode = .scaleAspectFit
        self.downBox.addSubview(configView)
        
        configView.translatesAutoresizingMaskIntoConstraints = false
        configView.leftAnchor.constraint(equalTo: self.downBox.leftAnchor, constant: 20).isActive = true
        configView.bottomAnchor.constraint(equalTo: self.downBox.bottomAnchor, constant: -20).isActive = true
        configView.topAnchor.constraint(equalTo: self.downBox.topAnchor, constant: 20).isActive = true
        configView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        //Create e confg the reset button
        let resetButton = UIButton()
        resetButton.backgroundColor = UIColor.flLightYellow
        resetButton.layer.borderWidth = 5.0
        resetButton.layer.borderColor = UIColor.flDarkYellow.cgColor
        resetButton.layer.cornerRadius = 20.0
        resetButton.setTitle("Finalizar Gincana", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        self.downBox.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.rightAnchor.constraint(equalTo: self.downBox.rightAnchor, constant: -20).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: self.downBox.bottomAnchor, constant: -20).isActive = true
        resetButton.topAnchor.constraint(equalTo: self.downBox.topAnchor, constant: 20).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 400).isActive = true
        resetButton.addTarget(self, action: #selector(buttonTarget(_:)), for: .primaryActionTriggered)
    }
    
    @objc func buttonTarget(_ selector: UIButton){
        //Finalizar a gincana e chamar a tela de vencedor
        print("oi")
    }
    
    func gamesBoxConfiguration() {
        
    }
}
