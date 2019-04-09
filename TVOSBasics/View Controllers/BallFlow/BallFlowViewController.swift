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

    let ballPanForceFactor: CGFloat = 100
    
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
        
    lazy var textualGameAlert: TextualGameAlert = {
        let textualGameAlert = TextualGameAlert.init(withAlertTitle: "Attention", text: "Your Turn. Press Play to continue...", andContentTitle: Team.red.description.capitalized) {
            self.scene.initiateGame(forTeam: .red)
            self.gameDelegate?.beginGame(withTeam: .red)
        }
        return textualGameAlert
    }()
    
    override public var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [textualGameAlert.gameAlertView]
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
        view.addSubview(textualGameAlert.gameAlertView)
        
        self.sceneView.backgroundColor = UIColor.flLightBlue
        
        self.gameDelegate = gameController
        
        self.scoreBoardView.titleLabel.text = "Flow Ball Game"
        self.scoreBoardView.setRound(to: 1, of: numberOfRounds)
    }
    
    @objc func swipeHappend(recognizer: ForceSwipeGestureRecognizer) {
        if recognizer.state == .ended {
            let panForce = recognizer.force(in: sceneView)
        
//            if panForce.z <= 0 {
                scene.moveBall(withForce: panForce)
//                print(panForce)
//            }
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
            self.textualGameAlert.reset(withTitle: team.description.capitalized, andText: "Your Turn. Press Play to continue..") {
                self.scene.initiateGame(forTeam: team)
                self.scoreBoardView.currentTeam = team
            }
        }
    }
    
    func setViewForChangeOfRound(toTeam team: Team, withRedRounds redRounds: Int, andBlueRounds blueRounds: Int, nextRoundNumber: Int) {
        DispatchQueue.main.async {
            self.textualGameAlert.gameAlertView.isHidden = false
            self.textualGameAlert.reset(withTitle: team.description.capitalized, andText: "Your Turn. Press Play to continue..") {
                self.scoreBoardView.currentTeam = team
                self.scoreBoardView.setMedalPointsTo(team: .red, points: redRounds)
                self.scoreBoardView.setMedalPointsTo(team: .blue, points: blueRounds)
                self.scene.initiateRound(forTeam: team)
            }
            
            self.scoreBoardView.setRound(to: nextRoundNumber, of: self.numberOfRounds)
        }
    }
    
    func setViewForEndGame() {
        DispatchQueue.main.async {
            self.textualGameAlert.gameAlertView.isHidden = false
            self.textualGameAlert.reset(withTitle: "End Game", andText: "")
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
