import UIKit

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

class ViewController: UIViewController, GameResultDelegate  {
    
    var textLabel: UILabel!
    var inputNumber: String = ""
    var game: NumberGuessingGame!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Инициализация игры
        game = NumberGuessingGame()
        game.loadGame()
        

        // Создание и размещение элементов интерфейса
        setupUI()
    }

    func setupUI() {
        // Label для отображения вводимого числа
        textLabel = UILabel()
        textLabel.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 40)
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(textLabel)

        // Кнопки для цифр от 0 до 9
        for i in 0...9 {
            let digitButton = UIButton(type: .system)
            digitButton.setTitle("\(i)", for: .normal)
            digitButton.frame = CGRect(x: 20 + (i % 3) * 80, y: 120 + (i / 3) * 60, width: 60, height: 40)
            digitButton.addTarget(self, action: #selector(digitButtonPressed(_:)), for: .touchUpInside)
            view.addSubview(digitButton)
        }

        // Кнопка "Стереть"
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("Стереть", for: .normal)
        clearButton.frame = CGRect(x: 20, y: 300, width: 120, height: 40)
        clearButton.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
        view.addSubview(clearButton)

        // Кнопка "Подтвердить"
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Подтвердить", for: .normal)
        confirmButton.frame = CGRect(x: 160, y: 300, width: 120, height: 40)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        view.addSubview(confirmButton)
        
        // Обновление интерфейса
        updateUI()
    }

    @objc func digitButtonPressed(_ sender: UIButton) {
        guard let digitText = sender.titleLabel?.text,
              let digit = Int(digitText) else {
            return
        }

        if inputNumber.count < 2 && digit <= 10 {
            inputNumber += digitText
            updateUI()
        }
    }


    @objc func clearButtonPressed() {
        inputNumber = ""
        updateUI()
    }

    @objc func confirmButtonPressed() {
        if let guessedNumber = Int(inputNumber) {
            let result = game.guess(number: guessedNumber)

            // Показываем результатный экран
            let resultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameResultViewController") as! GameResultViewController
            resultViewController.attempts = game.attempts
            resultViewController.isNumberGuessed = (result.range(of: "Поздравляю") != nil)
            resultViewController.delegate = self
            present(resultViewController, animated: true, completion: nil)
            inputNumber = ""
            
            // Обновление интерфейса
            updateUI()

            // Сохранение игрового состояния
            game.saveGame()
        } else {
            showAlert(message: "Введите число от 0 до 9.")
        }
    }
    
    
    
    func didTapContinue() {
        dismiss(animated: true, completion: nil)

    }
    
    func didTapNewGame() {
        game = NumberGuessingGame()
        game.saveGame()
        inputNumber = ""
        
        // Обновление интерфейса
        updateUI()
        dismiss(animated: true, completion: nil)

    }
    func updateUI() {
        textLabel.text = inputNumber
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Результат", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
