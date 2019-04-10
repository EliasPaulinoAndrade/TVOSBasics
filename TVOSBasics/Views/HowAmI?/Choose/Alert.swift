//
//  Alert.swift
//  TVOSBasics
//
//  Created by Levy Cristian  on 10/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class Alert: UIView {

    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        view.layer.borderColor = UIColor.flDarkYellow.cgColor
        view.layer.borderWidth = 5
        return view
    }()

    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "The Game is going to start in"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    
    private lazy var informationLabel: UILabel = {
        let label = UILabel()
        label.text = "30 \n seconds"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 70)
        
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var teamName: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 70)
        
        label.numberOfLines = 0
        return label
    }()
    
    private func add(){
        self.addSubview(whiteView)
        whiteView.addSubview(title)
        whiteView.addSubview(informationLabel)
        whiteView.addSubview(teamName)
        
    }
    
    init(frame: CGRect, teamName: String) {
        super.init(frame: frame)
        self.teamName.text = teamName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        whiteView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        whiteView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        title.anchor(top: whiteView.safeAreaLayoutGuide.topAnchor,
                        leading: whiteView.safeAreaLayoutGuide.leadingAnchor,
                        bottom: nil,
                        trailing: whiteView.safeAreaLayoutGuide.trailingAnchor,
                        padding: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0),
                        size: .zero)
        
        informationLabel.anchor(top: title.safeAreaLayoutGuide.bottomAnchor,
                                leading: whiteView.safeAreaLayoutGuide.leadingAnchor,
                                bottom: nil,
                                trailing: whiteView.safeAreaLayoutGuide.trailingAnchor,
                                padding: UIEdgeInsets.zero,
                                size: .zero)
        
        teamName.anchor(top: informationLabel.safeAreaLayoutGuide.bottomAnchor,
                        leading: whiteView.safeAreaLayoutGuide.leadingAnchor,
                        bottom: nil,
                        trailing: whiteView.safeAreaLayoutGuide.trailingAnchor,
                        padding: UIEdgeInsets.zero,
                        size: .zero)
        
        
    }
    
}
