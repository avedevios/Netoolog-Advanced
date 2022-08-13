import UIKit

//Task 1

func resultOfCalculate(closure: (Double, Double) -> Double) {
    print(closure(3.5, 5.6))
}

let calculateSum = { (x: Double, y: Double) -> Double in
    return x + y
}

let calculateComposition = { (x: Double, y: Double) -> Double in
    return x * y
}

resultOfCalculate(closure: calculateSum)
resultOfCalculate(closure: calculateComposition)

//Task 2

print("-------")

let calculateSumShort: (Double, Double) -> Double = {
    $0 + $1
}

let calculateCompositionShort: (Double, Double) -> Double = {
    $0 * $1
}
resultOfCalculate(closure: calculateSumShort)
resultOfCalculate(closure: calculateCompositionShort)

//Task 3

print("-------")

resultOfCalculate { $0 - $1 }

//Это называется последующее замыкание или вынос замыкания за скобки, начиная с версии 5.3 Swift выносить можно больше 1 замыкания из списка параметров.
//При этом синтаксис первого по порядку замыкания можно писать без параметра, а последующие с параметром, напр.:
//func () {
//some code of first closure
//} param: {
//some code of second closure
//}
