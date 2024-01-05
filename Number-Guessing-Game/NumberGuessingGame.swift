import Foundation

class NumberGuessingGame {
    var secretNumber: Int
    var attempts: Int
    var isNewGame: Bool
    var guessedNumber: Int?
    
    init() {
        secretNumber = Int.random(in: 1...10)
        attempts = 0
        isNewGame = true
    }
    
    func guess(number: Int) -> String {
        attempts += 1
        guessedNumber = number
        
        if number == secretNumber {
            isNewGame = true
            return "Поздравляю! Вы угадали число \(secretNumber) с \(attempts) попытки."
        } else {
            return "\(secretNumber)Попробуйте еще раз.\(attempts)"
        }
    }
    
    func saveGame() {
        let defaults = UserDefaults.standard
        defaults.set(attempts, forKey: "attempts")
        defaults.set(secretNumber, forKey: "secretNumber")
        defaults.set(isNewGame, forKey: "isNewGame")
        defaults.set(guessedNumber, forKey: "guessedNumber")
    }
    
    func loadGame() {
        let defaults = UserDefaults.standard
        attempts = defaults.integer(forKey: "attempts")
        secretNumber = defaults.integer(forKey: "secretNumber")
        isNewGame = defaults.bool(forKey: "isNewGame")
        guessedNumber = defaults.integer(forKey: "guessedNumber")
    }
}
