import Foundation

class Spoon {
	
	init(index: Int) {
		self.index = index
	}
	
	func pickUp() {
		lock.lock()
	}
	
	func putDown() {
		lock.unlock()
	}
	
	private let lock = NSLock()
	
	let index: Int
}

class Developer {
	
	init(index: Int, leftSpoon: Spoon, rightSpoon: Spoon) {
		self.index = index
		self.leftSpoon = leftSpoon
		self.rightSpoon = rightSpoon
	}
	
	func run() {
		while true {
			think()
			eat()	
		}
	}
	
	private func think() {
		let lowerSpoon: Spoon
		let higherSpoon: Spoon
		if rightSpoon.index < leftSpoon.index {
			lowerSpoon = rightSpoon
			higherSpoon = leftSpoon
		} else {
			lowerSpoon = leftSpoon
			higherSpoon = rightSpoon
		}
		lowerSpoon.pickUp()
		higherSpoon.pickUp()
	}	
	
	private func eat() {
		let eatTime = arc4random_uniform(UInt32(1e2))
		print("developer \(index) eating for \(Double(eatTime)/1e3) ms")
		usleep(eatTime)
		rightSpoon.putDown()
		usleep(eatTime)
		leftSpoon.putDown()
		print("developer \(index) finished eating")
	}
		
	let index: Int
	
	let leftSpoon: Spoon
	let rightSpoon: Spoon
}

let spoons = [Spoon(index: 0), Spoon(index: 1), Spoon(index: 2), Spoon(index: 3), Spoon(index: 4)]
let developers = [Developer(index: 0, leftSpoon: spoons[0], rightSpoon: spoons[4]),
Developer(index: 1, leftSpoon: spoons[1], rightSpoon: spoons[0]),
Developer(index: 2, leftSpoon: spoons[2], rightSpoon: spoons[1]),
Developer(index: 3, leftSpoon: spoons[3], rightSpoon: spoons[2]),
Developer(index: 4, leftSpoon: spoons[4], rightSpoon: spoons[3])]

DispatchQueue.concurrentPerform(iterations: 5) {
	developers[$0].run()
}

dispatchMain()