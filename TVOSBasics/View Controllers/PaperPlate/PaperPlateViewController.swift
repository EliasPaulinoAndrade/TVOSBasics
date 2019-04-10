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
    let force = SCNVector3(0, 0, -40)
    var scoreBoardView = ScoreBoardView.init()
    var gameDelegate: GameViewControllerDelegate?
    
    lazy var gameAlertView: GameAlertView = {
        let gameAlertView = GameAlertView.init(text: "Vez da Equipe \(Team.red). Pressione Play para continuar.") {
            self.scnScene.initiateGame(forTeam: .red)
            self.gameDelegate?.beginGame(withTeam: .red)
        }
        return gameAlertView
    }()
    
    lazy var gameController: GameController = {
        let gameController = GameController.init(withGameViewControler: self)
        
        return gameController
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupGestures()
        self.scnScene.addNewBall()
        self.scnScene.newPlates()

        view.addSubview(scoreBoardView)
        view.addSubview(gameAlertView)
        
        self.scnView.backgroundColor = UIColor.flLightBlue
        
        self.gameDelegate = gameController
        
        self.scoreBoardView.titleLabel.text = "Paper Plate Game"
        self.scoreBoardView.setRound(to: 1, of: 5)
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

extension PaperPlateViewController: GameViewControllerProtocol {
    
    var gameType: GameType {
        return .paperPlate
    }
    
    var numberOfRounds: Int {
        return 5
    }
    
    func setViewForChangeOf(team: Team) {
        DispatchQueue.main.async {
            self.gameAlertView.isHidden = false
            self.gameAlertView.reset(withText: "Vez da Equipe \(team). Pressione Play para continuar.") {
                self.scnScene.initiateGame(forTeam: team)
                self.scoreBoardView.currentTeam = team
            }
        }
    }
    
    func setViewForChangeOfRound(toTeam team: Team, withRedRounds redRounds: Int, andBlueRounds blueRounds: Int, nextRoundNumber: Int) {
        DispatchQueue.main.async {
            self.gameAlertView.isHidden = false
            self.gameAlertView.reset(withText: "Novo round. Vez da Equipe \(team). Pressione Play para continuar.") {
                self.scoreBoardView.currentTeam = team
                self.scoreBoardView.setMedalPointsTo(team: .red, points: redRounds)
                self.scoreBoardView.setMedalPointsTo(team: .blue, points: blueRounds)
                self.scnScene.initiateRound(forTeam: team)
            }
            
            self.scoreBoardView.setRound(to: nextRoundNumber, of: self.numberOfRounds)
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
