//
//  ContentView.swift
//  Gusto
//
//  Created by Kyusaku Mihara on 2024/03/24.
//

import SwiftUI
import SwiftData

enum SortType: String, CaseIterable {
    case name
    case price
    case quality
    case speed
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Restaurant.priceRating, order: .reverse) var restaurants: [Restaurant]
    @State var sortType = SortType.name

    var body: some View {
        NavigationStack {
            RestaurantListView(sortType: sortType)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        do {
                            try modelContext.transaction {
                                restaurants.forEach {
                                    modelContext.delete($0)
                                }
                            }
                        } catch {
                            print(error)
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        modelContext.insert(Restaurant(name: "Sample", priceRating: 1, qualityRaiting: 1, speedRating: 1, addressInformation: .init(address: "None", latitude: 0, longitude: 0)))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Price") {
                        sortType = .price
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Quality") {
                        sortType = .quality
                    }
                }
            }
        }
    }
}

struct RestaurantListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var restaurants: [Restaurant]

    init(sortType: SortType) {
        let predicate = #Predicate<Restaurant> {
            $0.priceRating > 2 && $0.qualityRaiting > 1
        }
        switch sortType {
        case .name:
            _restaurants = Query(filter: predicate, sort: \Restaurant.name)
        case .price:
            _restaurants = Query(filter: predicate, sort: \Restaurant.priceRating)
        case .quality:
            _restaurants = Query(filter: predicate, sort: \Restaurant.qualityRaiting)
        case .speed:
            _restaurants = Query(filter: predicate, sort: \Restaurant.speedRating)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink(destination: {
                        RestaurantEditView(restaunt: restaurant)
                    }, label: {
                        HStack {
                            VStack {
                                Text(restaurant.name)
                                HStack {
                                    Text("Price")
                                    Text(restaurant.priceRating, format: .number)
                                }
                                HStack {
                                    Text("Quality")
                                    Text(restaurant.qualityRaiting, format: .number)
                                }
                                HStack {
                                    Text("Speed")
                                    Text(restaurant.speedRating, format: .number)
                                }
                            }
                            Spacer()
                            Text(restaurant.average, format: .number)
                        }
                    })
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach {
                        modelContext.delete(restaurants[$0])
                    }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
