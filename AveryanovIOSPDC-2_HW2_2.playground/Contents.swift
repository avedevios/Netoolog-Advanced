import UIKit

//Task 1

enum Countries {
    case USA
    case Russia
    case China
    case Italy
    case Sweden
    case SouthKorea
    
}

struct Track {
    var name: String
    var author: String
    var duration: Int
    var country: Countries
}

class Category {
    var name: String
    var list: [Track] = []
    
    //Здесь должно было быть lazy, но ругается, что вычисляемые свойства не могут быть lazy
    var number: Int {
        get {
            list.count
        }
    }
    
    func addTrack(addingTrack: Track) {
        if !list.contains(where: {$0.name == addingTrack.name}) {
            list.append(addingTrack)
        }
    }
    
    func removeTrack(removingTrack: Track) {
        if let removingIndex = list.firstIndex(where: {$0.name == removingTrack.name}) {
            list.remove(at: removingIndex)
        }
    }
    
    init (name: String) {
        self.name = name
    }
}

//Task 2

class Library {
    var name: String
    var list: [Category] = []
    
    //Здесь должно было быть lazy, но ругается, что вычисляемые свойства не могут быть lazy
    var number: Int {
        get {
            list.count
        }
    }
    
    func addCategory(addingCategory: Category) {
        if !list.contains(where: {$0.name == addingCategory.name}) {
            list.append(addingCategory)
        }
    }
    
    func removeTrack(removingCategory: Category) {
        if let removingIndex = list.firstIndex(where: {$0.name == removingCategory.name}) {
            list.remove(at: removingIndex)
        }
    }
    
    func move(_ movingTrack: Track, from categoryFrom: Category, to categoryTo: Category) {
        if list.contains(where: {$0.name == categoryFrom.name}) && list.contains(where: {$0.name == categoryTo.name}) {
            if categoryFrom.list.contains(where: {$0.name == movingTrack.name}) {
                categoryTo.addTrack(addingTrack: movingTrack)
                categoryFrom.removeTrack(removingTrack: movingTrack)
            } else {
                print("\(categoryFrom.name) don`t contains \(movingTrack.name)")
            }
        } else {
            print("This library don`t contains all or one of selected categories")
        }
    }
    
    init (name: String) {
        self.name = name
    }
}

//Test

let track1 = Track(name: "Satisfaction", author: "BB", duration: 381, country: Countries.Italy)
let track2 = Track(name: "Mama Mia", author: "ABBA", duration: 405, country: Countries.Sweden)
let track3 = Track(name: "Gangam Style", author: "PSI", duration: 351, country: Countries.SouthKorea)

let category1 = Category(name: "POP")
category1.addTrack(addingTrack: track1)
category1.addTrack(addingTrack: track2)
category1.addTrack(addingTrack: track3)

category1.number
category1.list

category1.removeTrack(removingTrack: track1)

category1.number
category1.list

let category2 = Category(name: "Dance")
category2.addTrack(addingTrack: track1)

category2.number
category2.list

let library1 = Library(name: "MyLibrary")
library1.addCategory(addingCategory: category1)
library1.addCategory(addingCategory: category2)

library1.number
library1.list

//Task 3

library1.move(track1, from: category2, to: category1)

category1.list
category2.list
