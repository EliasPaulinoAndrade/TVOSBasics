//
//  WireView.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 06/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class WireView: UIView {

    var wirePointRadius: CGFloat
    
    lazy var firstEndView: UIView = {
        let firstEndView = UIView.init()
        
        firstEndView.backgroundColor = UIColor.black
        firstEndView.layer.cornerRadius = self.wirePointRadius/2
        
        return firstEndView
    }()
    
    lazy var secondEndView: UIView = {
        let secondEndView = UIView.init()
        
        secondEndView.backgroundColor = UIColor.black
        secondEndView.layer.cornerRadius = self.wirePointRadius/2
        
        return secondEndView
    }()
    
    init(wirePointRadius: CGFloat) {
        self.wirePointRadius = wirePointRadius
        
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.black
        
        addSubview(firstEndView)
        addSubview(secondEndView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        firstEndView.translatesAutoresizingMaskIntoConstraints = false
        secondEndView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstEndView.widthAnchor.constraint(equalToConstant: wirePointRadius),
            firstEndView.heightAnchor.constraint(equalToConstant: wirePointRadius),
            secondEndView.widthAnchor.constraint(equalToConstant: wirePointRadius),
            secondEndView.heightAnchor.constraint(equalToConstant: wirePointRadius),
            
            firstEndView.centerXAnchor.constraint(equalTo: centerXAnchor),
            firstEndView.centerYAnchor.constraint(equalTo: topAnchor),
            
            secondEndView.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondEndView.centerYAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
