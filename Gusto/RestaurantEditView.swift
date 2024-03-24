//
//  RestaurantEditView.swift
//  Gusto
//
//  Created by Kyusaku Mihara on 2024/03/24.
//

import SwiftUI

struct RestaurantEditView: View {
    @State var restaunt: Restaurant

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $restaunt.name)
                Picker("Price Rating", selection: $restaunt.priceRating) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                }
                Picker("Quality Rating", selection: $restaunt.qualityRaiting) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                }
                Picker("Speed Rating", selection: $restaunt.speedRating) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                }
            }
            Section {
                TextField("Address", text: $restaunt.addressInformation.address)
            } header: {
                Text("Address Information")
            }

        }
    }
}

#Preview {
    RestaurantEditView(restaunt: .init(name: "", priceRating: 1, qualityRaiting: 2, speedRating: 3, addressInformation: .init(address: "None", latitude: 0, longitude: 0)))
}
