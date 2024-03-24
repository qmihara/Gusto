//
//  Models.swift
//  Gusto
//
//  Created by Kyusaku Mihara on 2024/03/24.
//

import Foundation
import SwiftData

typealias Restaurant = SchemaV1.Restaurant

enum SchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(1, 0, 0)
    static var models: [any PersistentModel.Type] = [
        Restaurant.self
    ]

    @Model class Restaurant {
        var name: String
        var priceRating: Int
        var qualityRaiting: Int
        var speedRating: Int

        var average: Double {
            Double((priceRating + qualityRaiting + speedRating)) / 3.0
        }

        init(name: String, priceRating: Int, qualityRaiting: Int, speedRating: Int) {
            self.name = name
            self.priceRating = priceRating
            self.qualityRaiting = qualityRaiting
            self.speedRating = speedRating
        }
    }

}

enum SchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version = .init(2, 0, 0)
    static var models: [any PersistentModel.Type] = [
        Restaurant.self,
        AddressInformation.self,
    ]

    @Model class Restaurant {
        var name: String
        var priceRating: Int
        var qualityRaiting: Int
        var speedRating: Int
        @Relationship var addressInformation: AddressInformation

        var average: Double {
            Double((priceRating + qualityRaiting + speedRating)) / 3.0
        }

        init(name: String, priceRating: Int, qualityRaiting: Int, speedRating: Int, addressInformation: AddressInformation) {
            self.name = name
            self.priceRating = priceRating
            self.qualityRaiting = qualityRaiting
            self.speedRating = speedRating
            self.addressInformation = addressInformation
        }
    }

    @Model class AddressInformation {
        var address: String
        var latitude: Double
        var longitude: Double

        init(address: String, latitude: Double, longitude: Double) {
            self.address = address
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}
