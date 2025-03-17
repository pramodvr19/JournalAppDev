//
//  ContentView.swift
//  CarMax
//
//  Created by Venkoba Rao, Pramod on 2/16/25.
//


import SwiftUI

// Model representing a car
struct Car: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    let price: String
    let year: Int
    let mileage: String
}

// Sample Data
let sampleCars = [
    Car(name: "2021 Toyota Camry", image: "car1", price: "$24,500", year: 2021, mileage: "32,000 miles"),
    Car(name: "2020 Honda Accord", image: "car2", price: "$22,900", year: 2020, mileage: "28,500 miles"),
    Car(name: "2019 Ford Mustang", image: "car3", price: "$27,800", year: 2019, mileage: "18,000 miles"),
    Car(name: "2022 Tesla Model 3", image: "car4", price: "$39,500", year: 2022, mileage: "5,000 miles")
]

// Main View
struct CarListView: View {
    @State private var searchText = "" //variable is used for search input

    var filteredCars: [Car] {
        searchText.isEmpty ? sampleCars : sampleCars.filter { $0.name.lowercased().contains(searchText.lowercased()) } //filtering cars based on search
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search cars...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // List of Cars
                List(filteredCars) { car in
                    NavigationLink(destination: CarDetailView(car: car)) {
                        HStack {
                            Image(car.image)
                                .resizable()
                                .frame(width: 80, height: 50)
                                .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(car.name)
                                    .font(.headline)
                                Text(car.price)
                                    .foregroundColor(.green)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("CarMax")
        }
    }
}

// Car Detail View
struct CarDetailView: View {
    let car: Car

    var body: some View {
        VStack {
            Image(car.image)
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .cornerRadius(10)

            Text(car.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 10)

            Text(car.price)
                .font(.title2)
                .foregroundColor(.green)

            HStack {
                Text("Year: \(car.year)")
                Spacer()
                Text("Mileage: \(car.mileage)")
            }
            .padding()
            .font(.subheadline)
            .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("Car Details")
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}

