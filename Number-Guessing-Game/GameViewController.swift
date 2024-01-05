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

class GameViewController: UIViewController, GameResultDelegate  {
    
    var textLabel: UILabel!
    var inputNumber: String = ""
    var game: NumberGuessingGame!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Инициализация игры
        game = NumberGuessingGame()
        game.loadGame()
        print("Загаданное число: \(game.secretNumber)")
        // Создание и размещение элементов интерфейса
        setupUI()
        //setupButtons()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)

        // Label для отображения вводимого числа
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 30)  // Adjust the font size as needed
        textLabel.textColor = .white
        textLabel.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1.0)
        textLabel.layer.cornerRadius = 15  // Adjust the corner radius as needed
        textLabel.clipsToBounds = true
        view.addSubview(textLabel)

        // Создание и размещение элементов интерфейса
        setupButtons()

        // Set constraints for textLabel
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20), // Adjust the spacing as needed
            textLabel.heightAnchor.constraint(equalToConstant: 80),  // Adjust the height as needed
        ])

        // Set constraints for buttonsStackView
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        // Обновление интерфейса
        updateUI()
    }

    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func setupButtons() {
        let row1 = createButtonRow(buttonTitles: ["1", "2", "3"])
        let row2 = createButtonRow(buttonTitles: ["4", "5", "6"])
        let row3 = createButtonRow(buttonTitles: ["7", "8", "9"])
        let row4 = createButtonRow(buttonTitles: ["Стереть", "0", "Подтвердить"])
        
        buttonsStackView.addArrangedSubview(row1)
        buttonsStackView.addArrangedSubview(row2)
        buttonsStackView.addArrangedSubview(row3)
        buttonsStackView.addArrangedSubview(row4)
        
        view.addSubview(buttonsStackView)
        
        // Set constraints for buttonsStackView
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func createButtonRow(buttonTitles: [String]) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        for title in buttonTitles {
            let button: UIButton
            if title == "Стереть" {
                button = UIButton(type: .system)
                button.setImage(UIImage(systemName: "xmark"), for: .normal)
                button.tintColor = UIColor.white
                let configuration = UIImage.SymbolConfiguration(pointSize: 30)
                button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
                button.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
            } else if title == "Подтвердить" {
                button = UIButton(type: .system)
                button.setImage(UIImage(systemName: "checkmark"), for: .normal)
                button.tintColor = UIColor.white
                let configuration = UIImage.SymbolConfiguration(pointSize: 30)
                button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
                button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
            } else {
                button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.addTarget(self, action: #selector(numberButtonPressed(_:)), for: .touchUpInside)
            }
            
            // Set the background color
            if  title == "Подтвердить" {
                button.backgroundColor = UIColor(red: 0/255, green: 176/255, blue: 160/255, alpha: 1.0)
            } else if title == "Стереть" {
                button.backgroundColor = UIColor(red: 255/255, green: 64/255, blue: 64/255, alpha: 1.0)
            } else {
                button.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1.0)
            }
            // Add corner radius for a rounded appearance
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            
            // Add width and height constraints
            //button.widthAnchor.constraint(equalToConstant: 80).isActive = true
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true


            // Set font size and text color
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            button.setTitleColor(.white, for: .normal)

            button.addTarget(self, action: #selector(numberButtonPressed(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
        }
        return stackView
    }




    
    @objc func numberButtonPressed(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            print("Button pressed: \(title)")
        }
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
        print("Загаданное число: \(game.secretNumber)")
        // Обновление интерфейса
        updateUI()
        dismiss(animated: true, completion: nil)
        
    }
    @objc func buttonPressed(_ sender: UIButton) {
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
    func updateUI() {
        // If there is no input number, show the default message
        if inputNumber.isEmpty {
            textLabel.text = "Введите число"
        } else {
            // If there is an input number, show it
            textLabel.text = inputNumber
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Помощь", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
