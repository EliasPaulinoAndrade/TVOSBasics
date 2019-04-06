//
//  Queue.swift
//  TVOSBasics
//
//  Created by Elias Paulino on 05/04/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

class Queue<T> {
    var queueList: [T] = []
    
    func push(item: T) {
        queueList.append(item)
    }
    
    func pull() -> T? {
        if queueList.count == 0 {
            return nil
        }
        return queueList.removeFirst()
    }
}
