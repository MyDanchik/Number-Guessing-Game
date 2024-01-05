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
    
    private let resultMessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(red: 255/255, green: 64/255, blue: 64/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 190).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать новую игру", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor(red: 0/255, green: 176/255, blue: 160/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 190).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        
        view.addSubview(resultLabel)
        view.addSubview(resultMessLabel)
        view.addSubview(continueButton)
        view.addSubview(newGameButton)
        
        resultLabel.font = UIFont.systemFont(ofSize: 30)
        resultLabel.textColor = .white
        
        
        resultMessLabel.font = UIFont.systemFont(ofSize: 20)
        resultMessLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: resultMessLabel.topAnchor, constant: -20),
            
            resultMessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultMessLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20)
        ])
    }
    
    func updateUI() {
        if isNumberGuessed {
            resultLabel.text = "Попыток: \(attempts)"
            resultMessLabel.text = "Поздравляю! Вы угадали число."
        } else {
            resultLabel.text = "Попыток: \(attempts)"
            resultMessLabel.text = "К сожалению, вы не угадали число."
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

