import UIKit

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
        
        
        let imageView = UIImageView(image: UIImage(named: "game"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        // Создание и размещение элементов интерфейса
        setupButtons()
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20),
            textLabel.heightAnchor.constraint(equalToConstant: 80),
            
            imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.29),
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
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
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
            
            if  title == "Подтвердить" {
                button.backgroundColor = UIColor(red: 0/255, green: 176/255, blue: 160/255, alpha: 1.0)
            } else if title == "Стереть" {
                button.backgroundColor = UIColor(red: 255/255, green: 64/255, blue: 64/255, alpha: 1.0)
            } else {
                button.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1.0)
            }
            
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(numberButtonPressed(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
        }
        return stackView
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
    func updateUI() {
        if inputNumber.isEmpty {
            textLabel.text = "Угадай число"
        } else {
            textLabel.text = inputNumber
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Помощь", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
            showAlert(message: "Введите число от 0 до 10.")
        }
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
}
