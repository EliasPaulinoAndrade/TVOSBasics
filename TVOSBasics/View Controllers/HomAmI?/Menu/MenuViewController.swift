//
//  MenuViewController.swift
//  TVOSBasics
//
//  Created by Levy Cristian  on 08/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "How am I?"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 60)
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red:0.95, green:0.71, blue:0.32, alpha:1.0)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red:0.93, green:0.64, blue:0.15, alpha:1.0).cgColor
        return button
    }()
    
    private lazy var rulesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rules", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red:0.95, green:0.71, blue:0.32, alpha:1.0)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red:0.93, green:0.64, blue:0.15, alpha:1.0).cgColor
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(red:0.45, green:0.70, blue:0.99, alpha:1.0)
        setUpViews()
    }
    
    private func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(startButton)
        view.addSubview(rulesButton)
    }
    
    private func addConstraints(){
        titleLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0), size: .zero)
        
        startButton.anchor(top: titleLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0), size: .zero)
        startButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1.2).isActive = true
        startButton.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 0.2).isActive = true
        startButton.centerXAnchor.constraint(equalToSystemSpacingAfter: titleLabel.centerXAnchor, multiplier: 1).isActive = true
        
        
        rulesButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20), size: .zero)
        rulesButton.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 0.1).isActive = true
        rulesButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, multiplier: 1.2).isActive = true
        
    }
    
    private func setUpViews(){
        addViews()
        addConstraints()
    }
    
}
