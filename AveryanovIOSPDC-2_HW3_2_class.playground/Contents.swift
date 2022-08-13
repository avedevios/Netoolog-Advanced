import UIKit
//import Foundation

enum DateSections {
    case year
    case month
    case date
}

enum BMWModels {
    case x3
    case x4
    case x5
    case x6
}

enum VolvoModels {
    case xc60
    case xc70
    case xc90
}

enum AudiModels {
    case q3
    case q5
    case q7
}

enum Models {
    case BMW (BMWModels)
    case Volvo (VolvoModels)
    case Audi (AudiModels)
    case Mercedes
    case Lada
}

enum Colors: CaseIterable {
    case white
    case black
    case brown
}

enum Accessories: CaseIterable {
    case tinting
    case wipers
    case mats
    case fireExtinguisher
    case firstAidKit
}

// Part 1

protocol IDable {
    var id: Int { get }
}

protocol Salesable {
    var salePrecentage: Int { get set }
}

protocol Carable: IDable, Salesable {
    var model: Models { get }
    var color: Colors { get }
    var buildDate: [DateSections : Int] { get }
    var price: Double { get set }
    var accessories: [Accessories] { get set }
    var isServiced: Bool { get set }
}

// Part 2

protocol Dealershipable {
    var name: String { get }
    var showroomCapacity: Int { get }
    var stockCars: [Carable] { get set }
    var showRoom: [Carable] { get set }
    var cars: [Carable] { get set }
    
    func offerAccessories(_ arrayAccessories: [Accessories])
    func presaleService(_ car: inout Carable)
    func addToShowroom(_ car: inout Carable)
    func sellCar(_ car: Carable)
    func orderCar()
}

protocol Sloganable {
    var slogan: String { get }
}

// Part 3

// Cars

class Car: Carable {
    var id: Int
    var model: Models
    var color: Colors
    var buildDate: [DateSections : Int]
    var price: Double = 0
    var accessories: [Accessories] = []
    var isServiced: Bool = false
    var salePrecentage: Int = 0
    
    init(id: Int,
         model: Models,
         color: Colors,
         buildDate: [DateSections : Int]) {
        
        self.id = id
        self.model = model
        self.color = color
        self.buildDate = buildDate
    }
}

// Dealers

class DealershipBMW: Dealershipable {
    var name: String
    var showroomCapacity: Int
    var stockCars: [Carable] = []
    var showRoom: [Carable] = []
    var cars: [Carable] {
        get {
            return stockCars + showRoom
        }
        set {}
    }
       
    func offerAccessories(_ arrayAccessories: [Accessories]) {
        if !arrayAccessories.isEmpty {
            print("You can offer next accessories:")
            arrayAccessories.forEach {
                print("- \($0)")
            }
        }
    }
    
    func presaleService(_ car: inout Carable) {

        if car.isServiced {
            print("\(car.model) with id: \(car.id) is already had a presale service")
        } else {
            car.isServiced = true
            
            print("\(car.model) with id: \(car.id) made a presale service")
        }
    }
    
    func addToShowroom(_ car: inout Carable) {
        if showRoom.count < showroomCapacity {
            if stockCars.contains(where: {$0.id == car.id}) {
                if !showRoom.contains(where: {$0.id == car.id}) {
                    
                    showRoom.append(car)
                    
                    stockCars.removeAll(where: {$0.id == car.id})
                    
                    presaleService(&car)

                    print("\(car.model) with id: \(car.id) added to showroom and deleted from stock")
                } else {
                    print("\(car.model) with id: \(car.id) is already in showroom")
                }
            } else {
                print("\(car.model) with id: \(car.id) isn`t in stock")
            }
        } else {
            print("Showroom capacity is full")
        }
    }
    
    func sellCar(_ car: Carable) {
        if showRoom.contains(where: {$0.id == car.id}) {
            if car.isServiced {
               
                showRoom.removeAll(where: {$0.id == car.id})
                
                print("\(car.model) with id: \(car.id) is sold")
               
                offerAccessories(car.accessories)
                
            } else {
                print("\(car.model) with id: \(car.id) can`t be sold because there is no presale service")
            }
        } else {
            print("\(car.model) with id: \(car.id) can`t be sold because it is out of showroom")
        }
    }
    
    func orderCar() {
        let randomID = Int.random(in: 100...999)
        let randomColor = Colors.allCases.randomElement()!
        let newCar = Car(id: randomID,
                         model: Models.BMW(BMWModels.x3),
                         color: randomColor,
                         buildDate: [DateSections.year : 2022, DateSections.month : 1, DateSections.date: 1])
        
        stockCars.append(newCar)
        
        print("New \(newCar.model) with id: \(newCar.id) added in stock")
    }
    
    init (name: String, showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
    }
}

// Test

// Cars instances

var id359: Carable = Car(id: 359,
                model: Models.BMW(BMWModels.x3),
                color: Colors.black,
                buildDate: [DateSections.year : 2021, DateSections.month : 5, DateSections.date: 1])

var id872: Carable = Car(id:872,
                model: Models.Volvo(VolvoModels.xc60),
                color: Colors.brown,
                buildDate: [DateSections.year : 2021, DateSections.month : 7, DateSections.date: 7])

var id568: Carable = Car(id: 568,
                model: Models.Audi(AudiModels.q5),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3])

var id658: Carable = Car(id: 658,
                model: Models.Audi(AudiModels.q7),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3])

var id865: Carable = Car(id: 865,
                model: Models.Audi(AudiModels.q3),
                color: Colors.white,
                buildDate: [DateSections.year : 2022, DateSections.month : 2, DateSections.date: 3])

var id733: Carable = Car(id: 733,
                model: Models.BMW(BMWModels.x4),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3])

var id353: Carable = Car(id: 353,
                model: Models.Volvo(VolvoModels.xc60),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3])

var id978: Carable = Car(id: 978,
                model: Models.BMW(BMWModels.x5),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3])

var id111: Carable = Car(id: 111,
                model: Models.Volvo(VolvoModels.xc90),
                color: Colors.white,
                buildDate: [DateSections.year : 2022, DateSections.month : 2, DateSections.date: 3])

var id246: Carable = Car(id: 246,
                model: Models.BMW(BMWModels.x6),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3])

// Dealer instances

let dealershipBMW = DealershipBMW(name: "BMW dealership", showroomCapacity: 2)

// Order car

dealershipBMW.orderCar()

// Append car instance

dealershipBMW.stockCars.append(id359)
dealershipBMW.stockCars.append(id733)
dealershipBMW.stockCars.append(id978)
dealershipBMW.stockCars.count
dealershipBMW.stockCars

// Add to showroom

dealershipBMW.addToShowroom(&id359)
dealershipBMW.addToShowroom(&id733)

id359.isServiced
dealershipBMW.showRoom[0].isServiced

// Error showroom capacity

dealershipBMW.addToShowroom(&id978)

dealershipBMW.showRoom.count
dealershipBMW.showRoom

dealershipBMW.stockCars.count
dealershipBMW.stockCars

// Sell car

dealershipBMW.sellCar(id359)

dealershipBMW.showRoom.count
dealershipBMW.showRoom

print("-------")

// Part 4

protocol SpecialOffer {
    func addEmergencyPack()
    func makeSpecialOffer()
}

extension DealershipBMW: SpecialOffer {
    
    func addEmergencyPack() {
        
        print("-------")
        print("Proccessing emergancy pack:")
        
        for index in 0...cars.count - 1 {
            if cars[index].salePrecentage > 0 {
                cars[index].accessories.append(Accessories.fireExtinguisher)
                cars[index].accessories.append(Accessories.firstAidKit)
                
                print("To \(cars[index].model) with id: \(cars[index].id) was added emergancy pack")
            }
        }
    }
    
    func makeSpecialOffer() {
        
        print("Processing special offer:")
        
        for index in 0...cars.count - 1 {
            if let buildDateYear = cars[index].buildDate[DateSections.year] {
                if buildDateYear < 2022 {
                    cars[index].salePrecentage = 15
                    
                    print("For \(cars[index].model) with id: \(cars[index].id) we maded special offer")
                }
            }
        }
        
        print("-------")
        print("Processing move to showroom:")
        
        for index in 0...cars.count - 1 {
            if cars[index].salePrecentage > 0 {
                if !showRoom.contains(where: {$0.id == cars[index].id}) {
                    
                    addToShowroom(&cars[index])
                    
                }
            }
        }
        addEmergencyPack()
    }
}

// Make special offer

// Test 978 car

dealershipBMW.cars
dealershipBMW.stockCars
dealershipBMW.showRoom

id978.id
id978.isServiced
id978.salePrecentage
id978.accessories

dealershipBMW.makeSpecialOffer()

id978.id
id978.isServiced
id978.salePrecentage
id978.accessories

dealershipBMW.cars
dealershipBMW.stockCars
dealershipBMW.showRoom
