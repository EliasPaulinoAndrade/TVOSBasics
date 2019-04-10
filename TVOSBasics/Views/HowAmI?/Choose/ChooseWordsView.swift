//
//  ChooseWordsView.swift
//  TVOSBasics
//
//  Created by Levy Cristian  on 08/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class ChooseWordsView: UIView {

    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.borderColor = UIColor.flDarkYellow.cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
     lazy var teamName: UILabel = {
        let label = UILabel()
        label.text = "hi"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 70)
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.text = "hi"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.numberOfLines = 0
        return label
    }()
    
    public lazy var inputField: FLTextField = {
        let textField = FLTextField(frame: CGRect.zero, placeholder: "speak here")
        return textField
    }()
    
    private lazy var button: FLButton = {
        let button = FLButton(frame: CGRect.zero, name: "next")
        return button
    }()
    
    init(frame: CGRect, teamName: String, informationLabel: String, buttonTarget: Selector){
        super.init(frame: frame)
        self.teamName.text = teamName
        self.informationLabel.text = informationLabel
        self.button.addTarget(self.superview, action: buttonTarget, for: .primaryActionTriggered)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func add(){
        self.addSubview(whiteView)
        whiteView.addSubview(teamName)
        whiteView.addSubview(informationLabel)
        whiteView.addSubview(inputField)
        self.addSubview(button)

    }
    
    override func didMoveToSuperview() {
        add()
        setUPConstraints()
        
    }
    
    private func setUPConstraints(){
       
        
        whiteView.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                        leading: nil,
                        bottom: nil,
                        trailing: nil,
                        padding: UIEdgeInsets.zero,
                        size: .zero)
        whiteView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7).isActive = true
        whiteView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        whiteView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        teamName.anchor(top: whiteView.safeAreaLayoutGuide.topAnchor,
                         leading: whiteView.safeAreaLayoutGuide.leadingAnchor,
                         bottom: nil,
                         trailing: whiteView.safeAreaLayoutGuide.trailingAnchor,
                         padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0),
                         size: .zero)

        informationLabel.anchor(top: teamName.safeAreaLayoutGuide.bottomAnchor,
                        leading: whiteView.safeAreaLayoutGuide.leadingAnchor,
                        bottom: nil,
                        trailing: whiteView.safeAreaLayoutGuide.trailingAnchor,
                        padding: UIEdgeInsets.zero,
                        size: .zero)

        inputField.anchor(top: informationLabel.safeAreaLayoutGuide.bottomAnchor,
                                leading: whiteView.safeAreaLayoutGuide.leadingAnchor,
                                bottom: nil,
                                trailing: whiteView.safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets(top: 60, left: 30, bottom: 0, right: 30),
                                size: .zero)
        inputField.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 0.2).isActive = true

        button.anchor(top: whiteView.bottomAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: nil,
                           padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0),
                           size: .zero)
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: whiteView.widthAnchor, multiplier: 0.3).isActive = true
        button.heightAnchor.constraint(equalTo: whiteView.heightAnchor, multiplier: 0.3).isActive = true

        
    }
}
