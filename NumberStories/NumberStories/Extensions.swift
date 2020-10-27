//
//  Extensions.swift
//  NumberStories
//
//  Created by Rankovic, Marko (Developer) on 02/12/2017.
//  Copyright © 2017 Marko Rankovic. All rights reserved.
//

func randomNonNegativeInt(upTo max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max + 1)))
}

func randomInt(from min: Int, to max: Int) -> Int {
    return randomNonNegativeInt(upTo: max - min) + min
}

func randomInts(from min: Int, to max: Int, count: Int) -> [Int] {
    assert(max - min + 1 >= count, "max - min <= count")
    var set: Set<Int> = []
    while set.count < count {
        set.insert(randomInt(from: min, to: max))
    }
    return Array(set)
}

extension Array {
    
    func each<U>(f: (Element) -> U) {
        for item in self {
            _ = f(item)
        }
    }
    
    func each<U>(f: (Int, Element) -> U) {
        for (index, item) in enumerated() {
            _ = f(index, item)
        }
    }
    
    func any(test: (Element) -> Bool) -> Bool {
        for item in self where test(item) {
            return true
        }
        return false
    }
    
    func all(test: (Element) -> Bool) -> Bool {
        for item in self where !test(item) {
            return false
        }
        return true
    }
}

import SpriteKit

extension SKAction {
    
    class func sequence(_ actions: SKAction...) -> SKAction {
        return sequence(actions)
    }
    
    class func group(_ actions: SKAction...) -> SKAction {
        return group(actions)
    }
}

extension SKNode {
    
    func childrenNamed(names: String...) -> [SKNode] {
        var nodes: [SKNode] = []
        for name in names {
            nodes += self[name]
        }
        return nodes
    }
    
    func fadeOutAndRemove(forDuration duration: TimeInterval) {
        name? += "Removed"
        removeAllActions()
        run(
            .sequence(
                .fadeAlpha(to: 0, duration: duration),
                .removeFromParent()
            )
        )
    }
}
