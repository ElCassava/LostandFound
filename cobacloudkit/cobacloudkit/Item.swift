//
//  Item.swift
//  cobacloudkit
//
//  Created by Sessario Ammar Wibowo on 26/03/25.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable {
    var id: UUID
    var dateFound: Date
    var dateClaimed: Date?
    var itemName: String
    var itemDescription: String
    var isClaimed: Bool
    var imageName: String
    var category: String
    var locationFound: String
    var claimer: String?
    
    init(id: UUID = UUID(), dateFound: Date, dateClaimed: Date? = nil, itemName: String, itemDescription: String, isClaimed: Bool = false, imageName: String = "salemalekum", category: String, locationFound: String, claimer: String? = nil) {
        self.id = id
        self.dateFound = dateFound
        self.dateClaimed = dateClaimed
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.isClaimed = isClaimed
        self.imageName = imageName
        self.category = category
        self.locationFound = locationFound
        self.claimer = claimer
    }
}

extension Item {
    static func dummyData() -> [Item] {
        return [
            Item(
                id: UUID(),
                dateFound: Date(timeIntervalSinceNow: -86400 * 2),
                dateClaimed: nil,
                itemName: "Wallet",
                itemDescription: "A black leather wallet with some cash and cards inside.",
                isClaimed: false,
                imageName: "wallet.png",
                category: "Accessories",
                locationFound: "Library",
                claimer: nil
            ),
            Item(
                id: UUID(),
                dateFound: Date(timeIntervalSinceNow: -86400 * 5),
                dateClaimed: Date(timeIntervalSinceNow: -86400 * 1),
                itemName: "Backpack",
                itemDescription: "A blue backpack containing books and a laptop charger.",
                isClaimed: true,
                imageName: "backpack.png",
                category: "Bags",
                locationFound: "Cafeteria",
                claimer: "John Doe"
            ),
            Item(
                id: UUID(),
                dateFound: Date(timeIntervalSinceNow: -86400 * 10),
                dateClaimed: nil,
                itemName: "Umbrella",
                itemDescription: "A red umbrella with a curved wooden handle.",
                isClaimed: false,
                imageName: "umbrella.png",
                category: "Miscellaneous",
                locationFound: "Bus Stop",
                claimer: nil
            ),
            Item(
                id: UUID(),
                dateFound: Date(timeIntervalSinceNow: -86400 * 7),
                dateClaimed: Date(timeIntervalSinceNow: -86400 * 3),
                itemName: "Smartphone",
                itemDescription: "A white iPhone 12 with a cracked screen protector.",
                isClaimed: true,
                imageName: "smartphone.png",
                category: "Electronics",
                locationFound: "Gym",
                claimer: "Jane Smith"
            )
        ]
    }
}


