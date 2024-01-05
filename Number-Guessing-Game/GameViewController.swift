import UIKit

final class GameViewController: UIViewController, GameResultDelegate {
    // MARK: - Properties
    
    var textLabel: UILabel!
    var inputNumber: String = ""
    var game: NumberGuessingGame!
    
    // MARK: - Lifecycle Methods
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Инициализация игры
        game = NumberGuessingGame()
        game.loadGame()
        print("Загаданное число: \(game.secretNumber)")
        // Создание и размещение элементов интерфейса
        setupUI()
    }
    // MARK: - Game Result Delegate Methods
    
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
}
