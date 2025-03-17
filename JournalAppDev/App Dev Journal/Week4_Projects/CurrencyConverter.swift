import SwiftUI

// Currency converter view
struct CurrencyConverterView: View {
    @State private var inputValue = "" // Amount to convert
    @State private var inputCurrency = "USD" // Input currency
    @State private var outputCurrency = "EUR" // Output currency

    let currencies = ["USD", "EUR", "GBP", "JPY", "AUD"] // List of currencies

    // Exchange rates between currency pairs
    let exchangeRates: [String: Double] = [
        "USDEUR": 0.85, "USDGBP": 0.75, "USDJPY": 110.0, "USDAUD": 1.35,
        "EURUSD": 1.18, "EURGBP": 0.88, "EURJPY": 129.0, "EURAUD": 1.60,
        "GBPUSD": 1.33, "GBPEUR": 1.14, "GBPJPY": 147.0, "GBPAUD": 1.82,
        "JPYUSD": 0.0091, "JPYEUR": 0.0078, "JPYGBP": 0.0068, "JPYAUD": 0.012,
        "AUDUSD": 0.74, "AUDEUR": 0.63, "AUDGBP": 0.55, "AUDJPY": 83.0
    ]

    // Calculate the converted value
    var convertedValue: Double {
        let input = Double(inputValue) ?? 0 // Convert input to number
        let key = inputCurrency + outputCurrency // Get exchange rate key
        let rate = exchangeRates[key] ?? 1.0 // Find the rate
        return input * rate // Convert value
    }

    var body: some View {
        Form {
            // Input section
            Section(header: Text("Input")) {
                TextField("Amount", text: $inputValue) // Enter amount
                    .keyboardType(.decimalPad) // Decimal pad keyboard
                Picker("From", selection: $inputCurrency) { // Select input currency
                    ForEach(currencies, id: \.self) { Text($0) }
                }
            }

            // Output section
            Section(header: Text("Output")) {
                Picker("To", selection: $outputCurrency) { // Select output currency
                    ForEach(currencies, id: \.self) { Text($0) }
                }
                Text("Converted Value: \(convertedValue, specifier: \"%.2f\")") // Display converted value
            }
        }
    }
}

// Preview of the view
struct CurrencyConverterView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterView() // Show preview
    }
}
