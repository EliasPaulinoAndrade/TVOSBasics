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

    let ballPanForceFactor: CGFloat = 1000
    
    var sceneView = SCNView.init()
    
    var scene = BallFlowScene.init()
    
    var scoreBoardView = ScoreBoardView.init()
    
    var gameController: GameController?
    
    var gameDelegate: GameViewControllerDelegate?
    
    var delegate: BallFlowViewControllerDelegate?
    
    var gameType: GameType = .flowBall
    
    var numberOfRounds = 3
    
    lazy var preferredFocusView: UIView = textualGameAlert.gameAlertView
        
    lazy var textualGameAlert: TextualGameAlert = {
        let textualGameAlert = TextualGameAlert.init(withAlertTitle: "Attention", text: "Your Turn. Press Play to continue...", andContentTitle: Team.red.description.capitalized) {
            self.scene.initiateGame(forTeam: .red)
            self.gameDelegate?.beginGame(withTeam: .red)
        }
        return textualGameAlert
    }()
    
    lazy var confirmGameAlert: ConfirmGameAlert = {
        let confirmGameAlert = ConfirmGameAlert.init(withAlertTitle: "Warning", buttonText: "Close", contentTitle: "The Current Game Will be Lost")

        confirmGameAlert.gameAlertView.isHidden = true

        return confirmGameAlert
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
        
        if self.gameController == nil {
            self.gameController = GameController.init(withGameViewControler: self)
            
        }
        self.gameDelegate = self.gameController
        self.gameController?.currentController = self
        
        
        view.addSubview(scoreBoardView)
        
        view.addSubview(textualGameAlert.gameAlertView)
        view.addSubview(confirmGameAlert.gameAlertView)
        
        self.sceneView.backgroundColor = UIColor.flLightBlue
        
        self.scoreBoardView.titleLabel.text = "Flow Ball Game"
        self.scoreBoardView.setRound(to: 1, of: numberOfRounds)
        setupInitialScoreBoard()
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.gameDidFinished(withGameController: gameController)
    }
    
    func setupInitialScoreBoard() {
        let currentGameInfo = gameDelegate?.currentInfo()
        
        if let redRounds = currentGameInfo?.redRounds {
            scoreBoardView.setMedalPointsTo(team: .red, points: redRounds)
        }
        
        if let blueRounds = currentGameInfo?.blueRounds {
            scoreBoardView.setMedalPointsTo(team: .blue, points: blueRounds)
        }
    }
    
    @objc func swipeHappend(recognizer: ForceSwipeGestureRecognizer) {
        if recognizer.state == .ended {
            let panForce = recognizer.force(in: sceneView)
        
            scene.moveBall(withForce: panForce)
        }
    }
    
    @objc func tapHappend(recognizer: UITapGestureRecognizer) {
        self.confirmGameAlert.gameAlertView.isHidden = false
        self.confirmGameAlert.gameAlertView.reset()

        self.preferredFocusView = self.confirmGameAlert.gameAlertView

        setNeedsFocusUpdate()
        updateFocusIfNeeded()

        self.confirmGameAlert.confirmCompletion = {
            self.dismiss(animated: true) {
                self.delegate?.gameDidFinished(withGameController: self.gameController)
            }
        }

        self.confirmGameAlert.completion = {
            self.preferredFocusView = self.textualGameAlert.gameAlertView

            self.setNeedsFocusUpdate()
            self.updateFocusIfNeeded()
        }
    }
    
    func setupInput() {
        let swipeRecognizer = ForceSwipeGestureRecognizer.init(
            target: self,
            action: #selector(swipeHappend(recognizer:)),
            forceFactor: ballPanForceFactor
        )
        
        let menuTapRecognizer = UITapGestureRecognizer.init(
            target: self,
            action: #selector(tapHappend(recognizer:))
        )
        
        menuTapRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        
        sceneView.addGestureRecognizer(swipeRecognizer)
        view.addGestureRecognizer(menuTapRecognizer)
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
    
    func setViewForChangeOf(team: Team) {
        
        DispatchQueue.main.async {
            self.textualGameAlert.gameAlertView.isHidden = false
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
    
    func setViewForEndGame(winnerTeam: Team?, winnerRounds: Int?) {
        DispatchQueue.main.async {
            self.textualGameAlert.gameAlertView.isHidden = false
            
            var endGameMessage = "the game is tied"
            
            if let winnerTeam = winnerTeam, let winnerRounds = winnerRounds {
                endGameMessage = "\(winnerTeam.description.capitalized) is in front with \(winnerRounds) round. Press Play to back to Menu"
            }
            
            self.textualGameAlert.reset(withTitle: "End Game", andText: endGameMessage) {
                self.dismiss(animated: true, completion: {
                    self.delegate?.gameDidFinished(withGameController: self.gameController)
                })
            }
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
