import UIKit

var greeting = "Hello, playground"

protocol Priceable {
    var price: Double { get set }
}

protocol Carable: Priceable {
    var name: String { get set }
}

struct Car: Carable {
    var name: String
    var price: Double
}

class Dealer {
    var name: String
    var car: Carable
    var cars: [Carable]
    
    private func changeDeeper(_ car: inout Carable) {
        car.price = 300
    }
    
    func changePrice(_ car: inout Carable) {
        changeDeeper(&car)
    }
    
    init(name: String, car: Car, cars: [Car]) {
        self.name = name
        self.car = car
        self.cars = cars
    }
}

protocol Salesable {
    func makeSale()
}

class LambaDealer: Dealer { }

extension Dealer: Salesable {
    
    func makeSale() {
        for index in 0...cars.count - 1 {
            changePrice(&cars[index])
        }
    }
}

var lamba: Carable = Car(name: "Diablo", price: 100) //было 100

let vipDealer = LambaDealer(name: "VIP", car: lamba, cars: [lamba])

vipDealer.car.price = 200
vipDealer.car.price //стало 200

//vipDealer.changePrice(&vipDealer.car)
vipDealer.changePrice(&lamba)
vipDealer.car.price
lamba.price
// copy on write

vipDealer.makeSale()
vipDealer.cars[0].price
