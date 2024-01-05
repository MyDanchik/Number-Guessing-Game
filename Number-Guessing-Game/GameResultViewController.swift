import UIKit

protocol GameResultDelegate: AnyObject {
    func didTapContinue()
    func didTapNewGame()
}

class GameResultViewController: UIViewController {
    
    var attempts: Int = 0
    var isNumberGuessed: Bool = false
    
    weak var delegate: GameResultDelegate?
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать новую игру", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(resultLabel)
        view.addSubview(continueButton)
        view.addSubview(newGameButton)
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 10)
        ])
    }
    
    func updateUI() {
        if isNumberGuessed {
            resultLabel.text = "Поздравляю! Вы угадали число за \(attempts) попыток."
        } else {
            resultLabel.text = "К сожалению, вы не угадали число за \(attempts) попыток."
        }
    }
    
    @objc func continueButtonPressed() {
        delegate?.didTapContinue()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func newGameButtonPressed() {
        delegate?.didTapNewGame()
        dismiss(animated: true, completion: nil)
    }
}

