import Foundation

class Splitwise {
    var balances: [String: Double] = [:]  // Stores each person's net balance
    
    // Function to add an expense
    func addExpense(payer: String, amount: Double, participants: [String]) {
        let splitAmount = amount / Double(participants.count)  // Equal split among participants
        
        for person in participants {
            if person != payer {
                balances[person, default: 0.0] -= splitAmount  // They owe money
                balances[payer, default: 0.0] += splitAmount  // Payer gets credited
            }
        }
    }
    
    // Function to compute who owes whom
    func calculateDebts() -> [(String, String, Double)] {
        var debts: [(String, String, Double)] = []
        var positiveBalances = balances.filter { $0.value > 0 }.sorted { $0.value > $1.value }
        var negativeBalances = balances.filter { $0.value < 0 }.sorted { $0.value < $1.value }

        while !positiveBalances.isEmpty && !negativeBalances.isEmpty {
            var (creditor, creditAmount) = positiveBalances.removeFirst()
            var (debtor, debtAmount) = negativeBalances.removeFirst()
            let amountToSettle = min(creditAmount, -debtAmount)
            
            debts.append((debtor, creditor, amountToSettle))
            
            creditAmount -= amountToSettle
            debtAmount += amountToSettle
            
            if creditAmount > 0 {
                positiveBalances.insert((creditor, creditAmount), at: 0)
            }
            if debtAmount < 0 {
                negativeBalances.insert((debtor, debtAmount), at: 0)
            }
        }
        
        return debts
    }
}

// Example
let splitwise = Splitwise()
splitwise.addExpense(payer: "Alice", amount: 100, participants: ["Alice", "Bob", "Charlie"])
splitwise.addExpense(payer: "Bob", amount: 60, participants: ["Bob", "Charlie"])
splitwise.addExpense(payer: "Charlie", amount: 90, participants: ["Alice", "Charlie"])

let transactions = splitwise.calculateDebts()
for (debtor, creditor, amount) in transactions {
    print("\(debtor) owes \(creditor) $\(String(format: "%.2f", amount))")
}

