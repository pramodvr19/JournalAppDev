import SwiftUI

struct UnitConverterView: View {
    @State private var inputValue = ""
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"

    let units = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]

    var convertedValue: Double {
        let input = Double(inputValue) ?? 0

        let inputInMeters: Double
        switch inputUnit {
        case "Meters": inputInMeters = input
        case "Kilometers": inputInMeters = input * 1000
        case "Feet": inputInMeters = input * 0.3048
        case "Yards": inputInMeters = input * 0.9144
        case "Miles": inputInMeters = input * 1609.34
        default: inputInMeters = 0
        }

        switch outputUnit {
        case "Meters": return inputInMeters
        case "Kilometers": return inputInMeters / 1000
        case "Feet": return inputInMeters / 0.3048
        case "Yards": return inputInMeters / 0.9144
        case "Miles": return inputInMeters / 1609.34
        default: return 0
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Value", text: $inputValue)
                    .keyboardType(.decimalPad)
                Picker("Input Unit", selection: $inputUnit) {
                    ForEach(units, id: \ .self) { Text($0) }
                }
            }

            Section(header: Text("Output")) {
                Picker("Output Unit", selection: $outputUnit) {
                    ForEach(units, id: \ .self) { Text($0) }
                }
                Text("Converted Value: \(convertedValue, specifier: "%.2f")")
            }
        }
    }
}

struct UnitConverterView_Previews: PreviewProvider {
    static var previews: some View {
        UnitConverterView()
    }
}

