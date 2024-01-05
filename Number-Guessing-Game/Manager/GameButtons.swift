import UIKit

extension GameViewController {
    // MARK: - Button Action Methods
    
    @objc  func numberButtonPressed(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            print("Button pressed: \(title)")
        }
    }
    
    @objc  func digitButtonPressed(_ sender: UIButton) {
        guard let digitText = sender.titleLabel?.text,
              let digit = Int(digitText) else {
            return
        }
        
        if inputNumber.count < 2 && digit <= 10 {
            inputNumber += digitText
            updateUI()
        }
    }
    
    @objc  func clearButtonPressed() {
        inputNumber = ""
        updateUI()
    }
    
    @objc  func confirmButtonPressed() {
        if let guessedNumber = Int(inputNumber) {
            let result = game.guess(number: guessedNumber)
            
            // Показываем результатный экран
            let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameResultViewController") as! GameResultViewController
            resultViewController.attempts = game.attempts
            resultViewController.isNumberGuessed = (result.range(of: "Поздравляю") != nil)
            resultViewController.delegate = self
            present(resultViewController, animated: true, completion: nil)
            inputNumber = ""
            updateUI()
            game.saveGame()
        } else {
            showAlert(message: "Введите число от 0 до 10.")
        }
    }
    
    @objc  func buttonPressed(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            switch title {
            case "Стереть":
                clearButtonPressed()
            case "Подтвердить":
                confirmButtonPressed()
            default:
                digitButtonPressed(sender)
            }
        }
    }
    
    
    
}
