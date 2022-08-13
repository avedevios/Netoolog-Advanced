import UIKit

//Task 1

//Класс Регистрация на рейс авиакомпании
//Публичный метод - выдать посадочный талон
//Публичный метод - зарегистрировать багаж
//Приватный метод - выделить места для пассажиров
//Геттер - получить данные паспорта пассажира
//Сеттер - указать данные в посадочном талоне

//Task 2
class RegistrationPassanger {
    
    //Выдать посадочный талон по ФИО
    func talon (name: String, surname: String, secondName: String) {
    
    //Выдать посадочный талон по неполному имени для иностранцев
    }
    func talon (name: String, surname: String) {
    
    //Выдать посадочный талон по ИД пассажира
    }
    func talon (id: Int) {
        
    }
}

//Task 3
class Registration {
    func register() {
        print ("Welcome to our aircompany")
    }
}

class RegistrationLuggage: Registration {
    override func register() {
        super.register()
        print("Your luggage is registared")
    }
}

RegistrationLuggage().register()
