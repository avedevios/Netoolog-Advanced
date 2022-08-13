import UIKit

enum Countries {
    case litva
}

enum Genres {
    case pop
}

class Actor {
    var name: String
    var country: Countries
    var genres: [Genres]
    
    func makeTrack(track: String) {
        print("I, \(name), make a track \(track)")
    }
    
    func perfomTrack(track: String) {
        print("I, \(name), perfom a track \(track)")
    }
    
    init(name: String, country: Countries, genres: [Genres]) {
        self.name = name
        self.country = country
        self.genres = []

        for genre in genres {
            self.genres.append(genre)
        }
    }
}

final class Star: Actor {
    var rider: String
    
    func cancelEvent() {
        
    }
    
    override func makeTrack(track: String) {
        super.makeTrack(track: track)
        print("I am a Star")
        
    }
    
    override func perfomTrack(track: String) {
        super.makeTrack(track: track)
        print("I am a Star")
    }
    
    init(name: String, country: Countries, genres: [Genres], rider: String) {
        self.rider = rider
        super.init(name: name, country: country, genres: genres)
    }
}

final class SuperStar: Actor {
    var brand: String
    
    func goToTheHall() {
        
    }
    
    override func makeTrack(track: String) {
        super.makeTrack(track: track)
        print("I am a Super Star")
        
    }
    
    override func perfomTrack(track: String) {
        super.makeTrack(track: track)
        print("I am a Super Star")
    }

    init(name: String, country: Countries, genres: [Genres], brand: String) {
        self.brand = brand
        super.init(name: name, country: country, genres: genres)
    }
}

final class MegaStar: Actor {
    var TradeMark: String
    
    func winGrammy() {
        
    }

    override func makeTrack(track: String) {
        super.makeTrack(track: track)
        print("I am a Mega Star")
        
    }
    
    override func perfomTrack(track: String) {
        super.makeTrack(track: track)
        print("I am a Mega Star")
    }
    
    init(name: String, country: Countries, genres: [Genres], TradeMark: String) {
        self.TradeMark = TradeMark
        super.init(name: name, country: country, genres: genres)
    }
}

//Test

let kirkorov = Actor(name: "Kirkorov", country: Countries.litva, genres: [])
let urgant = Star(name: "Urgant", country: Countries.litva, genres: [], rider: "Private plane, omars")
let usher = SuperStar(name: "Usher", country: Countries.litva, genres: [], brand: "Usher Brand")
let madonna = MegaStar(name: "Madonna", country: Countries.litva, genres: [], TradeMark: "Dance like Madonna")

kirkorov.makeTrack(track: "LaLaLand")
kirkorov.perfomTrack(track: "LaLaLand")

print("-----")

urgant.makeTrack(track: "LaLaLand")
urgant.perfomTrack(track: "LaLaLand")
urgant.rider // Task 2

print("-----")

usher.makeTrack(track: "LaLaLand")
usher.perfomTrack(track: "LaLaLand")
usher.brand // Task 2

print("-----")

madonna.makeTrack(track: "LaLaLand")
madonna.perfomTrack(track: "LaLaLand")
madonna.TradeMark // Task 2

// Task 3

var arrayActors: [Actor] = []

arrayActors.append(kirkorov)
arrayActors.append(urgant)
arrayActors.append(usher)
arrayActors.append(madonna)

//Попрактиковался в наследовании классов, переопределении методов и закрытии классов от дальнейшего наследования
//Разобрался как переопределять методы с параметрами
//Разобрался как инициализировать массивы
//Убедился, что в инициализаторе дочернего класса - родительский инициализатор должен стоять в самом конце, после инициализации новых свойств дочернего класса
//Стало открытием, что в массив с типом родительского класса, можно добавлять экземпляры дочерних классов
