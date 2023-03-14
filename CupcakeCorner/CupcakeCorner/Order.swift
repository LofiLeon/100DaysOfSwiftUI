//
//  Order.swift
//  CupcakeCorner
//
//  Created by Leon Grimmeisen on 30.03.22.
//

import SwiftUI

class SharedOrder: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = Order()
}

struct Order: Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        // sets frosting and sprinkles to disabled once special requests are disabled
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }
    
    var cost : Double {
        //2$ per cake
        var cost = Double(quantity) * 2
        
        //complicated cakes cost more
        cost += (Double(type) / 2)
        
        //1$ per cake for extra frosting
        if extraFrosting {
            cost += (Double(quantity))
        }
        
        //0.5$ per cake for sprinkles
        if extraFrosting {
            cost += (Double(quantity) / 2)
        }
        
        return cost
    }
}
