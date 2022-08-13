import UIKit

//Task 1
protocol Runable {
    var legsNumber: Int { get set }
    
    func run()
}

class MathOperation {
    private var x: Double
    private var y: Double
    
    func doMath() {
        
    }
}

struct Clock {
    var smallClock: Int
    var bigClock: Int
}

enum Months {
    case november
    case april
}

//Task 2
//Соревнования велосепидистов - это композиция, так как конкретные участники не должны существовать вне соревнований
//Учет ремонтов велосипедов - это абстракция, так как сущность велосипед должна существовать вне ремонта
//Парад планет - это абстракция, так как каждая планета должна существовать вне парада
//Колонизация планет - это композиция, колонизация без планет не имеет смысла

