import UIKit

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

struct Pickup: Carable {
    var id: Int
    var model: Models
    var color: Colors
    var buildDate: [DateSections : Int]
    var price: Double
    var accessories: [Accessories]
    var isServiced: Bool = false
    var salePrecentage: Int = 0
}

struct Hatchback: Carable {
    var id: Int
    var model: Models
    var color: Colors
    var buildDate: [DateSections : Int]
    var price: Double
    var accessories: [Accessories]
    var isServiced: Bool = false
    var salePrecentage: Int = 0
}

struct Liftback: Carable {
    var id: Int
    var model: Models
    var color: Colors
    var buildDate: [DateSections : Int]
    var price: Double
    var accessories: [Accessories]
    var isServiced: Bool = false
    var salePrecentage: Int = 0
}

struct Sedan: Carable {
    var id: Int
    var model: Models
    var color: Colors
    var buildDate: [DateSections : Int]
    var price: Double
    var accessories: [Accessories]
    var isServiced: Bool = false
    var salePrecentage: Int = 0
}

struct Coup: Carable {
    var id: Int
    var model: Models
    var color: Colors
    var buildDate: [DateSections : Int]
    var price: Double
    var accessories: [Accessories]
    var isServiced: Bool = false
    var salePrecentage: Int = 0
}

// Dealers

class DealerMain: Dealershipable {
    var name: String
    var showroomCapacity: Int
    var stockCars: [Carable] = []
    var showRoom: [Carable] = []
    var cars: [Carable] = []
       
    func offerAccessories(_ arrayAccessories: [Accessories]) {
        if !arrayAccessories.isEmpty {
            print("You can offer next accessories:")
            arrayAccessories.forEach {
                print("- \($0)")
            }
        }
    }
    
    func presaleService(_ car: inout Carable) {
        if cars.contains(where: {$0.id == car.id}) {
            if car.isServiced {
                print("\(car.model) with id: \(car.id) is already had a presale service")
            } else {
                car.isServiced = true
                
                print("\(car.model) with id: \(car.id) made a presale service")
            }
        } else {
            print("\(car.model) with id: \(car.id) isn`t at current dealership")
        }
    }
    
    func addToShowroom(_ car: inout Carable) {
        if showRoom.count < showroomCapacity {
            if stockCars.contains(where: {$0.id == car.id}) {
                if !showRoom.contains(where: {$0.id == car.id}) {
                    
                    showRoom.append(car)
                    
                    stockCars.removeAll(where: {$0.id == car.id})
                                     
                    //presaleService(&car)
                    car.isServiced = true
                    
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
        let randomAccessory = Accessories.allCases.randomElement()!
        let newCar = Pickup(id: randomID,
                         model: Models.Lada,
                         color: randomColor,
                         buildDate: [DateSections.year : 2022, DateSections.month : 1, DateSections.date: 1],
                         price: 0.00,
                         accessories: [randomAccessory])
        
        stockCars.append(newCar)
        
        print("New \(newCar.model) with id: \(newCar.id) added in stock")
    }
    
    func refreshCars() {
        cars = stockCars + showRoom
    }
    
    init (name: String, showroomCapacity: Int) {
        self.name = name
        self.showroomCapacity = showroomCapacity
    }
}

class DealerBMW: DealerMain, Sloganable {
    var slogan: String = "The Ultimate Driving Machine"

    override func orderCar() {
        let randomID = Int.random(in: 100...999)
        let randomColor = Colors.allCases.randomElement()!
        let randomAccessory = Accessories.allCases.randomElement()!
        let newCar = Sedan(id: randomID,
                           model: Models.BMW(BMWModels.x3),
                           color: randomColor,
                           buildDate: [DateSections.year : 2022, DateSections.month : 1, DateSections.date: 1],
                           price: 0.00,
                           accessories: [randomAccessory])
        
        stockCars.append(newCar)
        
        print("New \(newCar.model) with id: \(newCar.id) added in stock")
    }
}

class DealerAudi: DealerMain, Sloganable {
    var slogan: String = "Vorsprung durch Technik"
    
    override func orderCar() {
        let randomID = Int.random(in: 100...999)
        let randomColor = Colors.allCases.randomElement()!
        let randomAccessory = Accessories.allCases.randomElement()!
        let newCar = Sedan(id: randomID,
                           model: Models.Audi(AudiModels.q3),
                           color: randomColor,
                           buildDate: [DateSections.year : 2022, DateSections.month : 1, DateSections.date: 1],
                           price: 0.00,
                           accessories: [randomAccessory])
        
        stockCars.append(newCar)
        
        print("New \(newCar.model) with id: \(newCar.id) added in stock")
    }
}

class DealerVolvo: DealerMain {
    override func orderCar() {
        let randomID = Int.random(in: 100...999)
        let randomColor = Colors.allCases.randomElement()!
        let randomAccessory = Accessories.allCases.randomElement()!
        let newCar = Coup(id: randomID,
                         model: Models.Volvo(VolvoModels.xc60),
                         color: randomColor,
                         buildDate: [DateSections.year : 2022, DateSections.month : 1, DateSections.date: 1],
                         price: 4500000.00,
                         accessories: [randomAccessory])
        
        stockCars.append(newCar)
        
        print("New \(newCar.model) with id: \(newCar.id) added in stock")
    }
}

class DealerMercedes: DealerMain, Sloganable {
    var slogan: String = "Das Beste oder Nichts"
 
    override func orderCar() {
        let randomID = Int.random(in: 100...999)
        let randomColor = Colors.allCases.randomElement()!
        let randomAccessory = Accessories.allCases.randomElement()!
        let newCar = Hatchback(id: randomID,
                         model: Models.Mercedes,
                         color: randomColor,
                         buildDate: [DateSections.year : 2022, DateSections.month : 1, DateSections.date: 1],
                         price: 4500000.00,
                         accessories: [randomAccessory])
        
        stockCars.append(newCar)
        
        print("New \(newCar.model) with id: \(newCar.id) added in stock")
    }
}

class DealerLada: DealerMain {}

// Test

// Cars instances

// Pickup

var id359: Carable = Pickup(id: 359,
                model: Models.BMW(BMWModels.x3),
                color: Colors.black,
                buildDate: [DateSections.year : 2021, DateSections.month : 5, DateSections.date: 1],
                price: 4500000.00,
                accessories: [])

var id872: Carable = Pickup(id:872,
                model: Models.Volvo(VolvoModels.xc60),
                color: Colors.brown,
                buildDate: [DateSections.year : 2021, DateSections.month : 7, DateSections.date: 7],
                price: 3500000.00,
                accessories: [])

// Hatchback

var id568: Carable = Hatchback(id: 568,
                model: Models.Audi(AudiModels.q5),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])

var id658: Carable = Hatchback(id: 658,
                model: Models.Audi(AudiModels.q7),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])

// Liftback

var id865: Carable = Liftback(id: 865,
                model: Models.Audi(AudiModels.q3),
                color: Colors.white,
                buildDate: [DateSections.year : 2022, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])

var id733: Carable = Liftback(id: 733,
                model: Models.BMW(BMWModels.x4),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])
// Sedan

var id353: Carable = Sedan(id: 353,
                model: Models.Volvo(VolvoModels.xc60),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])

var id978: Carable = Sedan(id: 978,
                model: Models.BMW(BMWModels.x5),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])
// Coup

var id111: Carable = Coup(id: 111,
                model: Models.Volvo(VolvoModels.xc90),
                color: Colors.white,
                buildDate: [DateSections.year : 2022, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])

var id246: Carable = Coup(id: 246,
                model: Models.BMW(BMWModels.x6),
                color: Colors.white,
                buildDate: [DateSections.year : 2021, DateSections.month : 2, DateSections.date: 3],
                price: 5000000.00,
                accessories: [])

// Dealer instances

// DealerBMW

let dealershipBMWFirst  = DealerBMW(name: "BMW dealership #1", showroomCapacity: 2)
let dealershipBMWSecond = DealerBMW(name: "BMW dealership #2", showroomCapacity: 2)

// DealerAudi

let dealershipAudiFirst  = DealerAudi(name: "Audi dealership #1", showroomCapacity: 2)
let dealershipAudiSecond = DealerAudi(name: "Audi dealership #2", showroomCapacity: 2)

// DealerVolvo

let dealershipVolvoFirst  = DealerVolvo(name: "Volvo dealership #1", showroomCapacity: 2)
let dealershipVolvoSecond = DealerVolvo(name: "Volvo dealership #2", showroomCapacity: 2)

// DealerMercedes

let dealershipMercedesFirst  = DealerMercedes(name: "Mercedes dealership #1", showroomCapacity: 2)
let dealershipMercedesSecond = DealerMercedes(name: "Mercedes dealership #2", showroomCapacity: 2)

// DealerLada

let dealershipLadaFirst  = DealerLada(name: "Lada dealership #1", showroomCapacity: 2)
let dealershipLadaSecond = DealerLada(name: "Lada dealership #2", showroomCapacity: 2)

// Order car

dealershipLadaFirst.orderCar()
dealershipLadaFirst.refreshCars()

dealershipMercedesFirst.orderCar()
dealershipMercedesFirst.refreshCars()

// Append car instance

dealershipBMWFirst.stockCars.append(id359)
dealershipBMWFirst.stockCars.append(id733)
dealershipBMWFirst.stockCars.append(id978)
dealershipBMWFirst.stockCars.count
dealershipBMWFirst.stockCars

dealershipBMWFirst.refreshCars()

// Add to showroom

id359.isServiced
id733.isServiced

dealershipBMWFirst.addToShowroom(&id359)
dealershipBMWFirst.addToShowroom(&id733)

id359.isServiced
id733.isServiced

// Как мы видим, в задании допущена чудовищная ошибка!
// Использовать структуры для машин категорически нельзя, просто потому что это value type
// Мы посоздавали экземпляры машин, а когда добавляли в сток, мы их тупо скопировали, а не перенесли, теперь в стоке совсем другие машины
// Однако, в функции addToShowroom мы передаем ссылку на машину, поэтому меняется именно оригинальная машина

dealershipBMWFirst.showRoom[0].isServiced
dealershipBMWFirst.showRoom[0].isServiced

// Error showroom capacity

dealershipBMWFirst.addToShowroom(&id978)

dealershipBMWFirst.showRoom.count
dealershipBMWFirst.showRoom

dealershipBMWFirst.stockCars.count
dealershipBMWFirst.stockCars

dealershipBMWFirst.refreshCars()

// Sell car

dealershipBMWFirst.sellCar(id359)

dealershipBMWFirst.showRoom.count
dealershipBMWFirst.showRoom

dealershipBMWFirst.refreshCars()

print("-------")

// Part 3

let dealershipArray: [Any] = [dealershipBMWFirst,
                              dealershipAudiFirst,
                              dealershipVolvoFirst,
                              dealershipMercedesFirst,
                              dealershipLadaFirst]

dealershipArray.forEach {dealership in
    if let dealersipWithSlogan = dealership as? Sloganable {
        print(dealersipWithSlogan.slogan)
    }
}

print("-------")

// Part 4

protocol SpecialOffer {
    func addEmergencyPack()
    func makeSpecialOffer()
}

extension DealerMain: SpecialOffer {
    
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
        
        print("\n")
        print("\(name):")
        
        print("-------")
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

dealershipBMWFirst.cars
dealershipBMWFirst.stockCars
dealershipBMWFirst.showRoom

dealershipBMWFirst.cars[0].id
dealershipBMWFirst.cars[0].salePrecentage
dealershipBMWFirst.cars[0].accessories

dealershipBMWFirst.makeSpecialOffer()

dealershipBMWFirst.cars[0].id
dealershipBMWFirst.cars[0].salePrecentage
dealershipBMWFirst.cars[0].accessories

dealershipBMWFirst.cars
dealershipBMWFirst.stockCars
dealershipBMWFirst.showRoom

dealershipLadaFirst.makeSpecialOffer()
dealershipMercedesFirst.makeSpecialOffer()
