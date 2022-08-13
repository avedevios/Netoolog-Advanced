import UIKit

//Enums

enum Errors: Error {
    case dishNotHot
    case dishNotCold
}

enum TypeOfPositions {
    case manager
    case chef
    case waiter
}

enum TypesOfDishes {
    case salad
    case hot
    case garnish
    case dessert
}

enum Ingredients {
    case salt
    case onion
    case meat
    case potato
    case tomato
    case cucumber
    case oil
    case egg
    case milk
    case flour
    case ice
}

//Protocols

protocol Employable {
    var name: String { get }
    var male: Bool { get }
    var age: Int { get set }
    var positionType: TypeOfPositions { get set }
}

protocol Dishable {
    var type: TypesOfDishes { get }
    var ingredients: [Ingredients] { get }
    var cookingTime: Int { get }
    var price: Float { get }
}

protocol Restaurantable {
    var name: String { get }
    var employees: [Employable] { get }
    var warehouse: [Ingredients:Int] { get set }
    var menu: [Dishable] { get set }
    var orderList: [Orderable] { get set }
    
    mutating func appendOrderList (order: Orderable)
}

protocol Orderable {
    var orderReceiptTime: (Int, Int) { get }
    var orderReturnTime: (Int?, Int?) { get set }
    var orderDishes: [Dishable] { get set }
    var ready: Bool { get set }
}

//Structs

struct Order: Orderable {
    var orderReceiptTime: (Int, Int)
    var orderReturnTime: (Int?, Int?)
    var orderDishes: [Dishable]
    var ready: Bool
}

struct Dish: Dishable {
    var type: TypesOfDishes
    var ingredients: [Ingredients]
    var cookingTime: Int
    var price: Float
}

struct Restaurant: Restaurantable {
    var name: String
    var employees: [Employable]
    var warehouse: [Ingredients:Int]
    var menu: [Dishable]
    var orderList: [Orderable]
    
    mutating func appendOrderList (order: Orderable) {
        orderList.append(order)
    }
}

//Classes

class Positions: Employable {
    var name: String
    var male: Bool
    var age: Int
    var positionType: TypeOfPositions
    
    init (name: String, male: Bool, age: Int, positionType: TypeOfPositions) {
        self.name = name
        self.male = male
        self.age = age
        self.positionType = positionType
    }
}

class Manager: Positions {
    func inventory (){
        
    }
}

class Waiter: Positions {
    func takeAnOrder (restaurant: Restaurantable, order: Orderable){
        restaurant.appendOrderList(order: order)
    }
    
    func giveAnOrder (order: Orderable){
        
    }
    
}

class Chef: Positions {
    func cook (dish: Dishable) throws {
        
    }
}

class ChefHot: Chef {
    override func cook(dish: Dishable) throws {
        guard dish.type == TypesOfDishes.hot
        else {
            throw Errors.dishNotHot
        }
    }
}

class ChefCold: Chef {
    override func cook(dish: Dishable) throws {
        guard dish.type != TypesOfDishes.hot
        else {
            throw Errors.dishNotCold
        }
    }
}

//Dishes

let springSalad: Dishable = Dish(type: TypesOfDishes.salad,
                                 ingredients: [Ingredients.onion,
                                               Ingredients.tomato,
                                               Ingredients.cucumber,
                                               Ingredients.oil,
                                               Ingredients.salt],
                                 cookingTime: 30,
                                 price: 45.50)

let omelet: Dishable = Dish(type: TypesOfDishes.hot,
                                 ingredients: [Ingredients.egg,
                                               Ingredients.milk,
                                               Ingredients.oil,
                                               Ingredients.salt],
                                 cookingTime: 20,
                                 price: 150.00)

let goulash: Dishable = Dish(type: TypesOfDishes.hot,
                                 ingredients: [Ingredients.meat,
                                               Ingredients.onion,
                                               Ingredients.oil,
                                               Ingredients.salt,
                                               Ingredients.flour],
                                 cookingTime: 60,
                                 price: 250.00)

let puree: Dishable = Dish(type: TypesOfDishes.garnish,
                                 ingredients: [Ingredients.potato,
                                               Ingredients.milk],
                                 cookingTime: 40,
                                 price: 100.00)

let icecream: Dishable = Dish(type: TypesOfDishes.dessert,
                                 ingredients: [Ingredients.ice,
                                               Ingredients.milk],
                                 cookingTime: 10,
                                 price: 20.00)

//Menus

let mainMenu = [springSalad, omelet, goulash, puree, icecream]

//Waiters

let waiterIvanova = Waiter(name: "Oxana",
                           male: false,
                           age: 23,
                           positionType: TypeOfPositions.waiter)

//Warehouses

var storage = [Ingredients.milk : 5,
               Ingredients.salt : 10,
               Ingredients.onion : 25,
               Ingredients.meat : 30,
               Ingredients.potato : 19,
               Ingredients.tomato : 45,
               Ingredients.cucumber : 32,
               Ingredients.oil : 93,
               Ingredients.egg : 24,
               Ingredients.flour : 12,
               Ingredients.ice : 9]

//Restaurant

var varejka: Restaurantable = Restaurant(name: "VAREJKA",
                                         employees: [waiterIvanova],
                                         warehouse: storage,
                                         menu: mainMenu,
                                        orderList: [])

var order356: Orderable = Order(orderReceiptTime: (13, 15),
                              orderDishes: [omelet,
                                           springSalad],
                              ready: false)
