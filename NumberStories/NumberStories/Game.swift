//
//  Game.swift
//  NumberStories
//
//  Created by Rankovic, Marko (Developer) on 02/12/2017.
//  Copyright © 2017 Marko Rankovic. All rights reserved.
//

class Game {
    
    let storyNumber: Int
    
    var leftTerm: Int = 0
    
    var rightTerm: Int {
        return storyNumber - leftTerm
    }
    
    init(storyNumber number: Int) {
        storyNumber = number
    }
    
    func setNewTask() {
        var n = leftTerm
        while n == leftTerm {
            n = randomInt(from: 0, to: storyNumber) // allowing the left or the right term to be zero!
        }
        leftTerm = n
    }
    
    func test(leftTerm: Int, rightTerm: Int) -> Bool {
        return self.leftTerm == leftTerm
            && self.rightTerm == rightTerm
    }
}
