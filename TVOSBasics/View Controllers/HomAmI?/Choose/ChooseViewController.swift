//
//  ChooseViewController.swift
//  TVOSBasics
//
//  Created by Levy Cristian  on 08/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {

    lazy var middlePlaceView: UIView = {
        let middlePlaceView = UIView.init()
        
        return middlePlaceView
    }()
    
    lazy var middleTitleSpace: UIView = {
        let middleTitleSpace = ScoreShadowView.init()
        
        middleTitleSpace.backgroundColor = UIColor.flYellow
        middleTitleSpace.layer.borderWidth = 5
        middleTitleSpace.layer.borderColor = UIColor.flDarkYellow.cgColor
        
        return middleTitleSpace
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        
        titleLabel.text = "Teams configuration"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 38)
        
        return titleLabel
    }()
    
    private lazy var alertView: Alert = {
        let alert = Alert(frame: CGRect.zero, teamName: "Red")
        return alert
    }()
    
    lazy var topWire = DoubleWireView.init(wireHeight: 100, verticalCenter: -120)
    
    private var fristTeam: Bool = true
    private lazy var containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let teamView :ChooseWordsView = {
        let view = ChooseWordsView(frame: CGRect.zero, teamName: "Red", informationLabel: "Choose your 5 words", buttonTarget: #selector(saveWord(_:)))
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        addViews()
        setUPConstraints()
        
    }

    private func addViews(){
        view.addSubview(middlePlaceView)
        
        middlePlaceView.addSubview(middleTitleSpace)
        middlePlaceView.addSubview(topWire)
        middleTitleSpace.addSubview(titleLabel)
        
        view.addSubview(containerView)
        containerView.addSubview(teamView)
    }
    
    private func setUPConstraints(){
        
        middlePlaceView.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets.zero, size: .zero)
        
        middlePlaceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        middlePlaceView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35).isActive = true
        middlePlaceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let superview = middleTitleSpace.superview {
            middleTitleSpace.anchor(top: superview.topAnchor, leading: superview.leadingAnchor, bottom: nil, trailing: superview.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: .zero)
            middleTitleSpace.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.3).isActive = true
            
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(titleLabel.constraints(toFill: middleTitleSpace))
        
        containerView.anchor(top: middlePlaceView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        teamView.fillSuperview()
    }

    @objc func saveWord(_ selector: UIButton){
        if fristTeam{
            updateLabels(view: self.teamView)
            fristTeam = false
        }else{
            
        }
    }
    private func updateLabels(view: ChooseWordsView){
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            view.alpha = 0
            view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                view.teamName.text = "Blue"
                view.alpha = 1
                view.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    private func setUpAlert(){
        
    }
}
