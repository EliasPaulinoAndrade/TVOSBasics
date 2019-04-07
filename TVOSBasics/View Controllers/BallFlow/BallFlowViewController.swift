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

public class BallFlowViewController: UIViewController, GameViewControllerProtocol {

    let ballPanForceFactor: CGFloat = 5000
    
    var sceneView = SCNView.init()
    
    var scene = BallFlowScene.init()
    
    var scoreBoardView = ScoreBoardView.init()
    
    lazy var gameController: GameController = {
        let gameController = GameController.init(withGameViewControler: self)
        
        return gameController
    }()
    
    var gameDelegate: GameViewControllerDelegate?
    
    var gameType: GameType = .flowBall
    
    var numberOfRounds = 5
        
    lazy var gameAlertView: GameAlertView = {
        let gameAlertView = GameAlertView.init(text: "Vez da Equipe \(Team.red). Pressione Play para continuar.") {
            self.scene.initiateGame(forTeam: .red)
            self.gameDelegate?.beginGame(withTeam: .red)
        }
        return gameAlertView
    }()
    
    override public var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [gameAlertView]
    }
    
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
        scene.delegate = self
        
        setupSceneView()
        setupInput()
        view.addSubview(scoreBoardView)
        view.addSubview(gameAlertView)
        
        self.sceneView.backgroundColor = UIColor.flLightBlue
        
        self.gameDelegate = gameController
    }
    
    @objc func swipeHappend(recognizer: ForceSwipeGestureRecognizer) {
        if recognizer.state == .ended {
            let panForce = recognizer.force(in: sceneView)
        
            scene.moveBall(withForce: panForce)
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
        
        NSLayoutConstraint.activate(
            sceneView.constraints(toFill: view)
        )
        
        sceneView.backgroundColor = UIColor.black
//        sceneView.showsStatistics = true
//        sceneView.debugOptions = .showPhysicsShapes
        sceneView.isUserInteractionEnabled = true
    }
    
    func setViewForChangeOf(team: Team) {
        
        DispatchQueue.main.async {
            self.gameAlertView.isHidden = false
            self.gameAlertView.reset(withText: "Vez da Equipe \(team). Pressione Play para continuar.") {
                self.scene.initiateGame(forTeam: team)
                self.scoreBoardView.currentTeam = team
            }
        }
    }
    
    func setViewForChangeOfRound(toTeam team: Team, withRedRounds redRounds: Int, andBlueRounds blueRounds: Int) {
        DispatchQueue.main.async {
            self.gameAlertView.isHidden = false
            self.gameAlertView.reset(withText: "Novo round. Vez da Equipe \(team). Pressione Play para continuar.") {
                self.scoreBoardView.currentTeam = team
                self.scoreBoardView.setMedalPointsTo(team: .red, points: redRounds)
                self.scoreBoardView.setMedalPointsTo(team: .blue, points: blueRounds)
                self.scene.initiateRound(forTeam: team)
            }
        }
    }
    
    func setViewForEndGame() {
        DispatchQueue.main.async {
            self.gameAlertView.isHidden = false
            self.gameAlertView.reset(withText: "End Game")
        }
    }
    
    func setViewForPointsChange(ofTeam team: Team, points: Int) {
        DispatchQueue.main.async {
            self.scoreBoardView.setPointsTo(team: team, points: points)
        }
    }
    
    func setViewForPositionChange(redWinner: Bool, blueWinner: Bool) {
        DispatchQueue.main.async {

            self.scoreBoardView.setMedals(blueIsGold: blueWinner, redIsGold: redWinner)
        }
    }
}

extension BallFlowViewController: BallFlowSceneDelegate {
    func newPoints(points: Int) {
        self.gameDelegate?.newPoints(points: points)
    }
    
    func finished() {
        self.gameDelegate?.teamHasFinished()
    }
}
