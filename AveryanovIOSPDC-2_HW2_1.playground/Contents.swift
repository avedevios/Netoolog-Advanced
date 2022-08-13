import UIKit

//Task 1
struct FirmModel {
    var firm: String
    var model: String
}

enum TvChannels {
    case CNN
    case FOX
    case Premier
    case Discovery
    case Disney
}

class TV {
       
    var firmModel: FirmModel
    var isOn: Bool
    
    enum CableVHS {
        case Cable (TvChannels)
        case VHS
    } //Task 3
    
    var cableVHS: CableVHS //Task 3
    
    func helperWhatOnTV () {
        if isOn {
            print("\(firmModel.firm) \(firmModel.model) translate:")
            switch cableVHS {
            case .VHS:
                print("VHS")
            case .Cable (let channelName):
                print("Channel: \(channelName)")
            }
        } else {
            print("Please turn \(firmModel.firm) \(firmModel.model) on")
        }
    }
    
    func whatOnTV () {
        helperWhatOnTV()
    }
    
    func changeChannel (to newChannel: TvChannels?) {
        if newChannel == nil {
            cableVHS = .VHS
            
            print("\(firmModel.firm) \(firmModel.model) turned channel off")
        } else {
            cableVHS = .Cable (newChannel!)
            
            print("\(firmModel.firm) \(firmModel.model) changed channel to: \(newChannel!)")
        }
    }
    
    init(firmModel: FirmModel, isOn: Bool, currentChannel: TvChannels?) {
        self.firmModel = firmModel
        self.isOn = isOn
        if currentChannel == nil {
            self.cableVHS = .VHS
        } else {
            self.cableVHS = .Cable (currentChannel!)
        }
    }
}

let tvLG = TV(firmModel: FirmModel(firm: "LG", model: "OLED"), isOn: true, currentChannel: TvChannels.CNN)

let tvVHS = TV(firmModel: FirmModel(firm: "SANYO", model: "VEGA"), isOn: true, currentChannel: nil)

let tvOff = TV(firmModel: FirmModel(firm: "SONY", model: "A71"), isOn: false, currentChannel: nil)

tvLG.whatOnTV()
print("----")
tvLG.changeChannel(to: .FOX)
print("----")
tvLG.whatOnTV()
print("----")
tvVHS.whatOnTV()
print("----")
tvOff.whatOnTV()
print("----")

//Task 2
print("----")

struct Preferences {
    var volume: Float
    var isColor: Bool
    
    init (volume: Float, isColor: Bool) {
        self.isColor = isColor
        var x: Float = volume
        if x < 0 {
            print("Volume can't be less then zero. Taking absolut of volume")
            print("----")
            x = abs(x)
        }
        if x > 1 {
            print("Volume can't be more then 1. Taking 0. + volume")
            print("----")
            x = 1 / x
        }
        self.volume = x
    }
}

class NewTV: TV {
    var preferences: Preferences
    
    override func whatOnTV() {
        super.helperWhatOnTV()
       
        if preferences.isColor {
            print("It is COLOR TV on volume \(String(format: "%.2f", preferences.volume))")
        } else {
            print("It is B/W TV on volume \(String(format: "%.2f", preferences.volume))")
        }
    }

    init (firmModel: FirmModel, isOn: Bool, currentChannel: TvChannels?, preferences: Preferences) {
        self.preferences = preferences
        super.init (firmModel: firmModel, isOn: isOn, currentChannel: currentChannel)
    }
}

var myPreferences = Preferences(volume: -67, isColor: true)

let tvSamsung = NewTV(firmModel: FirmModel(firm: "Samsung", model: "QLED"), isOn: true, currentChannel: TvChannels.CNN, preferences: myPreferences)

tvSamsung.whatOnTV()

