import Foundation

struct Car {
    let name: String
    let speed: Double  // mph
    let fuelEfficiency: Double  // mpg
    let price: Double  // in dollars
}

class CarComparison {
    var userPreferences: [String: Double] = [:]  // Weights for speed, fuel efficiency, price
    
    init(speedWeight: Double, fuelWeight: Double, priceWeight: Double) {
        let totalWeight = speedWeight + fuelWeight + priceWeight
        self.userPreferences["speed"] = speedWeight / totalWeight
        self.userPreferences["fuelEfficiency"] = fuelWeight / totalWeight
        self.userPreferences["price"] = priceWeight / totalWeight
    }
    
    // calculate a score based on user preferences
    func calculateScore(for car: Car) -> Double {
        let normalizedSpeed = car.speed / 250.0  // Assuming 250 mph is max speed
        let normalizedFuel = car.fuelEfficiency / 50.0  // Assuming 50 mpg is best
        let normalizedPrice = 1.0 - (car.price / 100000.0)  // Lower price is better
        
        let score = (normalizedSpeed * userPreferences["speed"]!) +
                    (normalizedFuel * userPreferences["fuelEfficiency"]!) +
                    (normalizedPrice * userPreferences["price"]!)
        
        return score * 100  // Convert to percentage-like score
    }
    
    // compare 3 cars
    func compareCars(_ cars: [Car]) {
        let sortedCars = cars.sorted { calculateScore(for: $0) > calculateScore(for: $1) }
        print("Car Comparison Results:")
        for car in sortedCars {
            print("\(car.name): Score = \(String(format: "%.2f", calculateScore(for: car)))")
        }
    }
}

// Example
let car1 = Car(name: "SportsCar X", speed: 220, fuelEfficiency: 20, price: 80000)
let car2 = Car(name: "Sedan Y", speed: 160, fuelEfficiency: 35, price: 40000)
let car3 = Car(name: "Economy Z", speed: 130, fuelEfficiency: 45, price: 25000)

let comparison = CarComparison(speedWeight: 0.7, fuelWeight: 0.2, priceWeight: 0.1)
comparison.compareCars([car1, car2, car3])
