//
//  ViewController.swift
//  HungryDevelopers
//
//  Created by Spencer Curtis on 2/20/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        var developersArray: [Developer] = []
        
        // Create 5 Spoons and 5 Developers giving each developer a left and right spoon.
        // Give each spoon an index from 1 to 5.
        let spoon1 = Spoon(index: 1)
        let spoon2 = Spoon(index: 2)
        let spoon3 = Spoon(index: 3)
        let spoon4 = Spoon(index: 4)
        let spoon5 = Spoon(index: 5)
        
        //let spoon1 = spoons
        //let spoon2 = spoons
        //let spoon3 = spoons
        //let spoon4 = spoons
        //let spoon5 = spoons
        
        // Note that developers will of course share spoons. Ever developer's right spoon is the next developer's left spoon.
        
        let developer1 = Developer(leftSpoon: spoon1, rightSpoon: spoon2, name: "Developer 1")
        let developer2 = Developer(leftSpoon: spoon2, rightSpoon: spoon3, name: "Developer 2")
        let developer3 = Developer(leftSpoon: spoon3, rightSpoon: spoon4, name: "Developer 3")
        let developer4 = Developer(leftSpoon: spoon4, rightSpoon: spoon5, name: "Developer 4")
        let developer5 = Developer(leftSpoon: spoon5, rightSpoon: spoon1, name: "Developer 5")
        
        
        
        //We need to append all the developers to the array
        
        developersArray.append(developer1)
        developersArray.append(developer2)
        developersArray.append(developer3)
        developersArray.append(developer4)
        developersArray.append(developer5)
        
        // Call run() on each developer in a different queue/thread. You can do this with the following code assuming you put your developers in an array: (Had to create an array and append all developers.)
        
        DispatchQueue.concurrentPerform(iterations: 5) {
            developersArray[$0].run()
        }
    }
}

class Spoon {
    
    private let lock = NSLock()
    
    init(index: Int) {
        self.index = index
    }
    
    // Add an index property to Spoon.
    var index: Int
    
    func pickUp() {
        lock.lock()
    }
    
    func putDown() {
        lock.unlock()
    }
}

class Developer {
    
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    var name: String
    
    init(leftSpoon: Spoon, rightSpoon: Spoon, name: String){
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
        self.name = name
    }
    
    func think() {
        //  think() should pick up both spoons before returning.
        //        leftSpoon.pickUp()
        //        rightSpoon.pickUp()
        print("\(name) is thinking")
        
        if leftSpoon.index > rightSpoon.index {
            
            self.leftSpoon.pickUp()
            print("\(name) picked up left spoon")
            self.rightSpoon.pickUp()
            print("\(name) picked up left spoon")
            
        } else {
            self.rightSpoon.pickUp()
            print("\(name) picked up left spoon")
            self.leftSpoon.pickUp()
            print("\(name) picked up left spoon")
        }
        
    }
    
    func eat() {
        
        // Write eat() so that a developer will always pick up their lower-numbered spoon first. (The order in which they put them down doesn't matter.)
        
        // eat() should pause for a random amount of time before putting both spoons down.
        print("\(name) starts to eat.")
        usleep(1_000_000)
        leftSpoon.putDown()
        print("\(name) puts down left spoon.")
        rightSpoon.putDown()
        print("\(name) puts down right spoon.")
        
        
    }
    
    func run() {
        
        print("Running...")
        
        let isTrue = true
        
        // These two should be called over and over again. Create a for loop or while loop to make them run forever but need to make a condition so that if that condition is true then run forever. Best way is to set a constant and make it true
        
        // This condition will always be true. It will run the code inside forever.
        if isTrue {
            
            think()
            eat()
        }
        run()
    }
}
